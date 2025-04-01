import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/createPostController.dart';
import 'package:projects/utils/util.dart';


class CustomCameraScreen extends StatelessWidget {
  final CreatePostController controller = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            SizedBox(
                height: Get.height,
                child: CameraPreview(controller.cameraController!)),

            // Progress Bar & Timer
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  // Progress Bar
                  LinearProgressIndicator(
                    value: controller.recordingSeconds.value / controller.maxRecordingTime,
                    backgroundColor: Colors.grey,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                    minHeight: 5,
                  ),
                  const SizedBox(height: 8),

                  // Timer Display
                  Text(
                    "${controller.recordingSeconds.value}s / 15s",
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Recording & Switch Camera Buttons
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Select Video from Gallery
                  FloatingActionButton(
                    onPressed: controller.pickVideo,
                    backgroundColor: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, color: Colors.black),
                        MyTextWidget(data: "Add", size: 10,)
                      ],
                    ),
                  ),

                  // Switch Camera Button
                  FloatingActionButton(
                    onPressed: controller.switchCamera,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.flip_camera_ios, color: Colors.black),
                  ),

                  // Start/Stop Recording Button
                  FloatingActionButton(
                    onPressed: controller.toggleRecording,
                    backgroundColor: controller.isRecording.value ? Colors.red : Colors.white,
                    child: Icon(
                      controller.isRecording.value ? Icons.stop : Icons.fiber_manual_record,
                      color: Colors.black,
                    ),
                  ),
                  // FloatingActionButton(
                  //   onPressed: () {
                  //     if (controller.recordedVideoPath.isNotEmpty) {
                  //       Get.to(() => VideoPreviewScreen(videoPath: controller.recordedVideoPath.value));
                  //     }
                  //   },
                  //   backgroundColor: Colors.white,
                  //   child: const Icon(Icons.video_library, color: Colors.black),
                  // ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}