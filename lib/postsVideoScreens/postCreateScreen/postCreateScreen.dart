import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/controllers/createPostController.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/util.dart';

import '../../utils/colorConstants.dart';
import '../../utils/helper/cameraHelper.dart';

import 'package:flutter/material.dart';

class PostCreateScreen extends StatelessWidget{
  PostCreateScreen({super.key});

  // late CameraHelper cameraHelper;
  RxnString imgUrl = RxnString();
  final CreatePostController imagePickerController = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    // cameraHelper = CameraHelper(this);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 20, top: 20, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                MyTextWidget(data: "Create New Post",),
                CommonButton(
                  btnTxt: "Next",
                  radius: 6,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {

              // cameraHelper.openImageVideoPicker();
              Utils.mediaOptions();

              // imagePickerController.pickImage(ImageSource.gallery);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: DottedBorder(
                  strokeWidth: 0.3,
                    color: fieldBorderColor,
                    child: SizedBox(
                      width: Get.width,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Image.asset("assets/images/ic_upload.png", scale: 2,),
                      MyTextWidget(data: "upload photos and videos here",)],
                      ),
                    )),
              ),
            ),
          ),
          Obx(() => imagePickerController.selectedImagePath.value == ''
              ? Text("No Image Selected", style: TextStyle(fontSize: 18))
              : Image.file(
            File(imagePickerController.selectedImagePath.value),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          )),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('Image Picker with GetX')),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Obx(() => imagePickerController.selectedImagePath.value == ''
  //               ? Text("No Image Selected", style: TextStyle(fontSize: 18))
  //               : Image.file(
  //             File(imagePickerController.selectedImagePath.value),
  //             width: 200,
  //             height: 200,
  //             fit: BoxFit.cover,
  //           )),
  //           SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: () => imagePickerController.pickImage(ImageSource.gallery),
  //             child: Text("Pick Image from Gallery"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () => imagePickerController.pickImage(ImageSource.camera),
  //             child: Text("Pick Image from Camera"),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // @override
  // void onSuccessFile(String selectedUrl, String fileType) {
  //   imgUrl.value = selectedUrl;
  // }
  //
  // @override
  // void onSuccessVideo(String selectedUrl, Uint8List? thumbnail) {
  //   // TODO: implement onSuccessVideo
  // }
}
