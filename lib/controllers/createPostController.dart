import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projects/data/models/videoUploadModel.dart';
import 'package:projects/utils/shared/dataResponse.dart';

import '../data/apiProvider/createPostApiProvider.dart';
import '../utils/helper/storageHelper.dart';
import '../utils/util.dart';

class CreatePostController extends GetxController {
  var selectedImagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();
  File? _videoFile;

  late CreatePostApiProvider createApiProvider = CreatePostApiProvider();
  late StorageHelper storageHelper = StorageHelper();

  CameraController? cameraController;
  late List<CameraDescription> cameras;
  RxBool isRecording = false.obs;
  RxString recordedVideoPath = ''.obs;
  RxBool isCameraInitialized = false.obs;
  RxBool isFrontCamera = false.obs;
  RxBool isFlash = false.obs;
  RxBool isCameraOn = false.obs;

  RxInt recordingSeconds = 0.obs; // Timer counter
  FlashMode _flashMode = FlashMode.off;
  Timer? timer;
  final int maxRecordingTime = 15;


  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      selectedImagePath.value = image.path;
    }
    // else {
    //   Get.snackbar("Error", "No image selected",
    //       snackPosition: SnackPosition.BOTTOM);
    // }
  }

  // open and record video
  @override
  void onInit() {
    super.onInit();
    initializeCamera();
    createApiProvider = CreatePostApiProvider();
    storageHelper = StorageHelper();
  }

  /// Initialize Camera
  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await cameraController!.initialize();
    isCameraInitialized.value = true;
    isCameraOn.value = !isCameraOn.value;
    update();
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


  ///Select gallery videos
  Future<void> pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      _videoFile = File(pickedFile.path);
    }
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

  /// Capture Photo
  Future<String?> capturePhoto() async {
    if (cameraController == null || !cameraController!.value.isInitialized) return null;

    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/photo_${DateTime.now().millisecondsSinceEpoch}.jpg';

    try {
      final XFile file = await cameraController!.takePicture();
      File(file.path).copy(imagePath);
      return imagePath;
    } catch (e) {
      print("Error capturing photo: $e");
      return null;
    }
  }

  /// Start Video Recording
  Future<void> startRecording() async {
    if (cameraController == null || !cameraController!.value.isInitialized) return;

    final directory = await getTemporaryDirectory();
    final videoPath = '${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

    try {
      await cameraController!.startVideoRecording();
      isRecording.value = true;
      recordedVideoPath.value = videoPath;
    } catch (e) {
      print("Error starting video recording: $e");
    }
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

  Future<void> postVideo(VideoUploadModel videoModel,
      List<File> videoFiles, List<File> imageFiles) async {
    if (await Utils.hasNetwork()) {
      Utils.showLoader();

      var response = await createApiProvider.uploadVideoApp(
        title: videoModel.title ?? '',
        location: videoModel.location ?? '',
        description: videoModel.description ?? '',
        videoFiles: videoFiles, // ✅ Now it's guaranteed to be List<File>
        userId: videoModel.userId ?? '',
        subCategory: videoModel.subCategory ?? '',
        image1: imageFiles,
      );

      Utils.hideLoader();

      if (response.success == true) {
        if (response.data != null) {
          final videoUpload = response.data as VideoUploadModel;
          print("show upload data ----> ${videoUpload.toJson()}");
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