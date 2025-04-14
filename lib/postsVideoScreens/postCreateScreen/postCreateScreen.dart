import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/controllers/createPostController.dart';
import 'package:projects/data/models/videoUploadModel.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/customCameraScreen.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/liveCameraScreen.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/uploadPostScreen.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/videoPreviewScreen.dart';
import 'package:projects/utils/util.dart';

import '../../utils/colorConstants.dart';
import '../../utils/commonWidgets/commonButton.dart';
import '../../utils/commonWidgets/commonTextField.dart';

class PostCreateScreen extends StatelessWidget{
  PostCreateScreen({super.key});

  // late CameraHelper cameraHelper;
  final ImagePicker _picker = ImagePicker();
  File? _videoFile;
  RxnString imgUrl = RxnString();
  final selected = 0.obs;
  final CreatePostController imagePickerController = Get.put(CreatePostController());

  final captionController = TextEditingController();
  final descController = TextEditingController();
  final locController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // cameraHelper = CameraHelper(this);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child:Obx(()=> selected.value == 0? VideoPickerScreen()
                :selected.value == 1?CustomCameraScreen()
                :selected.value == 2?LiveCameraScreen() :UploadPostScreen(),)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:() {
                      selected.value = 0;
                      // _pickVideo();
                    },
                    child: MyTextWidget(data: "Video",)),
                GestureDetector(
                    onTap: () {
                      selected.value = 1;
                    },
                    child: MyTextWidget(data: "Short",)),
                GestureDetector(
                    onTap: () {
                      selected.value = 2;
                      // _recordVideo();
                    },
                    child: MyTextWidget(data: "Live",)),
                GestureDetector(
                    onTap: () {
                      selected.value = 3;
                    },
                    child: MyTextWidget(data: "Post",)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
