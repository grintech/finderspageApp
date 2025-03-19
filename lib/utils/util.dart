import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/utils/colorConstants.dart';

import '../controllers/createPostController.dart';
import '../controllers/postProfileController.dart';
final CreatePostController imagePickerController = Get.put(CreatePostController());
final PostProfileController profileController = Get.put(PostProfileController());

class MyTextWidget extends StatelessWidget {
  final String? data;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextOverflow? overflow;

  const MyTextWidget({super.key, this.data, this.size, this.color, this.weight, this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      data??"",
      style: TextStyle(
          color: color ?? blackColor,
          overflow: overflow,
          fontSize: size ?? 14.0,
          fontWeight: weight
      ),
    );
  }
}

class Utils{
  static error(String? message) {
    if (message == null) {
      return;
    }
    Get.closeAllSnackbars();
    Get.snackbar(
      "",
      message,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 4),
      backgroundColor: fieldBorderColor,
      borderRadius: 10,
      snackPosition: SnackPosition.TOP,
      colorText: blackColor,
      titleText: const Text(
        "",
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 2,
        ),
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 17,
            height: 1.4),
      ),
    );
  }

  static mediaOptions(){
    showModalBottomSheet(
        isDismissible: true,
        context: Get.context!,
        builder: (context){
          return Container(
            height: 100,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap:() {
                      imagePickerController.pickImage(ImageSource.camera);
                      Get.back();
                    },
                    child: Icon(Icons.camera, color: Colors.white,)),
                GestureDetector(
                    onTap:() {
                      imagePickerController.pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    child: Icon(Icons.perm_media_outlined, color: Colors.white,))
              ],
            ),
          );
        });
  }

}