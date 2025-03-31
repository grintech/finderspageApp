import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';

import '../../controllers/createPostController.dart';
import '../../utils/util.dart';

class LiveCameraScreen extends StatelessWidget {
  LiveCameraScreen({super.key});

  final CreatePostController controller = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            CameraPreview(controller.cameraController!),
            Positioned(
              right: 10,
                top: 80,
                child: Column(
              children: [
                GestureDetector(
                  onTap:(){
                    controller.switchCamera();
                  },
                    child: Image.asset("assets/images/switch_camera.png",
                      scale: 12, color: whiteColor,))
              ],
            )),

            // Recording & Switch Camera Buttons
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Start/Stop Recording Button
                  GestureDetector(
                    onTap: controller.toggleRecording,
                    child: Container(
                      child: Container(
                        height: 40, width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color:controller.isRecording.value ? Colors.red : Colors.black, width: 6),
                          color: controller.isRecording.value ? Colors.red : Colors.white,
                        ),
                        child: Icon(
                          controller.isRecording.value ? Icons.stop : Icons.fiber_manual_record,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
