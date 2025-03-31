import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CreatePostController extends GetxController {
  var selectedImagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();
  File? _videoFile;

  CameraController? cameraController;
  late List<CameraDescription> cameras;
  RxBool isRecording = false.obs;
  RxString recordedVideoPath = ''.obs;
  RxBool isCameraInitialized = false.obs;
  RxBool isFrontCamera = false.obs;
  RxBool isFlash = false.obs;

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
  }

  /// Initialize Camera
  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await cameraController!.initialize();
    isCameraInitialized.value = true;
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

  @override
  void onClose() {
    stopCamera();
    timer?.cancel();
    super.onClose();
  }
}