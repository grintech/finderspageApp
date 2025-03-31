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
                top: 120,
                child: Column(
              children: [
                GestureDetector(
                  onTap:(){
                    controller.switchCamera();
                  },
                    child: Image.asset("assets/images/switch_camera.png",
                      scale: 12, color: whiteColor,)),
                GestureDetector(
                  onTap: controller.toggleFlash,
                    child: controller.isFlash.value
                        ?Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Icon(Icons.flash_off, color: whiteColor, size: 30,),
                        )
                        :Padding(
                      padding: const EdgeInsets.only(top: 18),
                          child: Icon(Icons.flash_on, color: whiteColor, size: 30,),
                        ))
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
                      height: controller.isRecording.value?70:60, width: controller.isRecording.value?70:60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color:controller.isRecording.value ? Colors.red : Colors.white, width: 3),
                      ),
                      child: controller.isRecording.value
                          ?Icon(Icons.stop, size: 60, color: Colors.red,)
                          :Container(height: 40, width: 40,
                        margin: EdgeInsets.all(controller.isRecording.value?12:6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color:Colors.red, width: 6),
                          color:  Colors.red,
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
