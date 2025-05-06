import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/data/models/videoUploadModel.dart';
import 'package:projects/utils/routes.dart';
import 'package:projects/utils/shared/dataResponse.dart';
import 'package:video_player/video_player.dart';

import '../data/apiConstants.dart';
import '../data/apiProvider/createPostApiProvider.dart';
import '../data/models/PostsListModel.dart';
import '../postsVideoScreens/postsHomeScreens/postsNavBarScreen.dart';
import '../utils/cropperScreen.dart';
import '../utils/helper/storageHelper.dart';
import '../utils/util.dart';

class CreatePostController extends GetxController {
  final selectedImagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();
  File? videoFile;

  late CreatePostApiProvider createApiProvider = CreatePostApiProvider();
  late StorageHelper storageHelper = StorageHelper();
  VideoPlayerController? playerController;
  final keyboardVisible = MediaQuery.of(Get.context!).viewInsets.bottom == 0.obs;
  final captionController = TextEditingController();

  var isLimitReached = false.obs;
  Rxn<VideoUploadModel> postModel = Rxn();

  CameraController? cameraController;
  late List<CameraDescription> cameras;
  RxBool isRecording = false.obs;
  RxString recordedVideoPath = ''.obs;
  RxBool isCameraInitialized = false.obs;
  RxBool isFrontCamera = false.obs;
  RxBool isFlash = false.obs;
  RxBool isCameraOn = false.obs;
  bool isCropping = true;
  double aspectRatio = 1 / 1;
  final ImagePicker picker = ImagePicker();

  RxInt recordingSeconds = 0.obs; // Timer counter
  FlashMode _flashMode = FlashMode.off;
  Timer? timer;
  final int maxRecordingTime = 15;

  final RxList<File> selectedFiles = <File>[].obs;
  RxList<String> existingNetworkMedia = <String>[].obs;
  final descController = TextEditingController();
  final locController = TextEditingController();
  final donationController = TextEditingController();

  void addFile(File file) {
    selectedFiles.add(file);
  }

  void removeFileAt(int index) {
    selectedFiles.removeAt(index);
  }

  void prefillFields(String? caption, String? location) {
    captionController.text = caption ?? '';
    locController.text = location ?? '';
  }

  Future<void> preloadExistingMedia() async {
    for (String mediaUrl in existingNetworkMedia) {
      try {
        await precacheImage(
          NetworkImage('${ApiConstants.postImgUrl}/$mediaUrl'),
          Get.context!,
        );
      } catch (e) {
        print('Failed to preload image: $mediaUrl, error: $e');
      }
    }
  }


  void setEditMedia(List<String> urls) async {
    existingNetworkMedia.value = urls;
    await preloadExistingMedia();
    existingNetworkMedia.refresh();
  }

  Future<void> pickImage(ImageSource source) async {

    final XFile? image = await picker.pickImage(source: source);
    if(isCropping == false) {
      if (image != null) {
        // selectedImagePath.value = image.path;
        selectedFiles.add(File(image.path));
        selectedFiles.refresh();
        print("this is image ===== >$selectedFiles");
      }
      else {
        Get.snackbar("Error", "No image selected",
            snackPosition: SnackPosition.BOTTOM);
      }
      return;
    }
    File? croppedFile;
    if (image != null) {
      croppedFile = await Get.to(() => CropperScreen(file: image.path, aspectRatio: aspectRatio,));
    }
    if (croppedFile != null) {
      debugPrint("Selected image => ${croppedFile.path}");
      selectedFiles.add(File(croppedFile.path));
      selectedFiles.refresh();
      print("this is image ===== >$selectedFiles");
    } else {
      debugPrint('No image selected.');
    }
  }

  ///Select gallery videos
  Future<void> pickVideo(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickVideo(source: source);

    if (pickedFile != null) {
      // videoFile = File(pickedFile.path);
      selectedFiles.add(File(pickedFile.path));

      // Dispose previous controller if any
      if (playerController != null) {
        await playerController!.dispose();
      }

      // Initialize new controller
      // playerController = VideoPlayerController.file(videoFile!)
      //   ..initialize().then((_) {
      //     update(); // If you're using GetX
      //   });
    }
  }

  // open and record video
  @override
  void onInit() {
    createApiProvider = CreatePostApiProvider();
    storageHelper = StorageHelper();
    captionController.addListener(() {
      isLimitReached.value = captionController.text.length >= 150;
    });
    resetData();
    super.onInit();
  }

  void resetData() {
    selectedFiles.clear();
    captionController.clear();
    locController.clear();
    existingNetworkMedia.clear();
    selectedImagePath.value = '';
  }
  void resetSelectedFiles(){
    selectedFiles.clear();
    captionController.clear();
    locController.clear();
    selectedImagePath.value = '';
  }

  /// Initialize Camera
  Future<bool> initializeCamera() async {
    try{
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await cameraController!.initialize();
    isCameraInitialized.value = true;
    isCameraOn.value = !isCameraOn.value;
    update();
    return true;
    }catch(e){
      print('Camera init failed: $e');
      return false;
    }
  }



  /// Stop Camera when not in use
  Future<void> stopCamera() async {
    if (cameraController != null && isCameraInitialized.value) {
      await cameraController!.dispose();
      isCameraInitialized.value = false;
      update();
    }
  }

  void stopVideo() {
    if (isCameraOn.value) {
      isCameraOn.value = !isCameraOn.value;
      // isCameraInitialized.value = false;
      // cameraController?.dispose();
    } else {
      initializeCamera();
    }
  }

  /// Start or Stop Video Recording with Timer
  Future<void> toggleRecording() async {
    if (cameraController == null || !cameraController!.value.isInitialized) return;

    if (isRecording.value) {
      // Stop recording
      await stopRecording();
    } else {
      // Start recording
      isRecording.value = true;
      recordingSeconds.value = 0; // Reset timer

      await cameraController!.startVideoRecording();
      startTimer();
      update();
    }
  }

  /// Timer function to track recording duration
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
      recordingSeconds.value++;

      if (recordingSeconds.value >= maxRecordingTime) {
        await stopRecording();
      }
    });
  }

  /// Switch between front and back camera
  Future<void> switchCamera() async {
    isFrontCamera.value = !isFrontCamera.value;
    int newCameraIndex = isFrontCamera.value ? 1 : 0;

    await stopCamera();
    cameraController = CameraController(cameras[newCameraIndex], ResolutionPreset.high);
    await cameraController!.initialize();
    isCameraInitialized.value = true;
    update();
  }


  ///toggle flash
  void toggleFlash() {
      if (_flashMode == FlashMode.off) {
        _flashMode = FlashMode.torch;
        isFlash.value = !isFlash.value;
      } else {
        _flashMode = FlashMode.off;
      }
      cameraController?.setFlashMode(_flashMode);

  }

  /// Stop Recording
  Future<void> stopRecording() async {
    if (cameraController == null || !cameraController!.value.isRecordingVideo) return;

    timer?.cancel();
    XFile videoFile = await cameraController!.stopVideoRecording();
    recordedVideoPath.value = videoFile.path;
    isRecording.value = false;
    recordingSeconds.value = 0;
    update();

    // Navigate to video preview screen
    // Get.toNamed('/preview', arguments: recordedVideoPath.value);
  }

  Future<void> postVideo(VideoUploadModel videoModel) async {
    if (await Utils.hasNetwork()) {
      print("show VideoModel Data -----> ${videoModel.toJson()}");
      Utils.showLoader();

      var response = await createApiProvider.uploadVideoApp(videoModel);

      Utils.hideLoader();

      if (response.success == true) {
        if (response.data != null) {
          final postsController = Get.find<PostsHomeController>();
          postsController.postsList.clear();
          // postsController.videoList.refresh();
          postsController.changeTabIndex(0);
          postsController.getPostLists();

        } else {
          handleError(response);
        }
      } else {
        Utils.showErrorAlert(response.message ?? "Upload failed");
      }
    } else {
      Utils.showErrorAlert("Please check your internet connection");
    }
  }


  Future<void> uploadPost(VideoUploadModel videoModel) async {
    if (await Utils.hasNetwork()) {
      print("show VideoModel Data -----> ${videoModel.toJson()}");
      Utils.showLoader();

      var response = await createApiProvider.uploadPostApp(videoModel);

      Utils.hideLoader();

      if (response.success == true) {
        if (response.data != null) {
          final postsController = Get.find<PostsHomeController>();
          postsController.postsList.clear();
          postsController.changeTabIndex(0);
            postsController.getPostLists();
        } else {
          handleError(response);
        }
      } else {
        Utils.showErrorAlert(response.message ?? "Upload failed");
      }
    } else {
      Utils.showErrorAlert("Please check your internet connection");
    }
  }

  Future<void> editPostApi(VideoUploadModel videoModel, int id) async {
    if (await Utils.hasNetwork()) {
      print("show VideoModel Data -----> ${videoModel.toJson()}");
      Utils.showLoader();

      var response = await createApiProvider.editPost(videoModel, id);

      Utils.hideLoader();

      if (response.success == true) {
        if (response.data != null) {
          Get.offAllNamed(Routes.postsHome);
          final postsController = Get.find<PostsHomeController>();
          // postsController.postsList.clear();
          // postsController.changeTabIndex(0);
            postsController.getPostLists();
        } else {
          handleError(response);
        }
      } else {
        Utils.showErrorAlert(response.message ?? "Upload failed");
      }
    } else {
      Utils.showErrorAlert("Please check your internet connection");
    }
  }


  Future<void> editVideoApi(VideoUploadModel videoModel, int id) async {
    if (await Utils.hasNetwork()) {
      print("show VideoModel Data -----> ${videoModel.toJson()}");
      Utils.showLoader();

      var response = await createApiProvider.editVideo(videoModel, id);

      Utils.hideLoader();

      if (response.success == true) {
        if (response.data != null) {
          Get.offAllNamed(Routes.postsHome);
          final postsController = Get.find<PostsHomeController>();
          postsController.postsList.clear();
          postsController.changeTabIndex(0);
            postsController.getPostLists();
        } else {
          handleError(response);
        }
      } else {
        Utils.showErrorAlert(response.message ?? "Upload failed");
      }
    } else {
      Utils.showErrorAlert("Please check your internet connection");
    }
  }


  @override
  void onClose() {
    stopCamera();
    timer?.cancel();
    super.onClose();
  }

  void handleError(dynamic response) {
    if (response.message != null) {
      Utils.showErrorAlert(response.message);
    } else if (response.error != null) {
      Utils.showErrorAlert(response.error);
    } else {
      Utils.showErrorAlert("Server Error. Please Try Again");
    }
  }
}