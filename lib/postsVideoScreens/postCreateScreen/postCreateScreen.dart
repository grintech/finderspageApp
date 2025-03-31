import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/controllers/createPostController.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/customCameraScreen.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/liveCameraScreen.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/videoPreviewScreen.dart';
import 'package:projects/utils/util.dart';

import '../../utils/colorConstants.dart';
import '../../utils/commonWidgets/commonButton.dart';

class PostCreateScreen extends StatelessWidget{
  PostCreateScreen({super.key});

  // late CameraHelper cameraHelper;
  final ImagePicker _picker = ImagePicker();
  File? _videoFile;
  RxnString imgUrl = RxnString();
  final selected = 0.obs;
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
          Expanded(
            child:Obx(()=> selected.value == 0? VideoPickerScreen()
                :selected.value == 1?CustomCameraScreen()
                :selected.value == 2?LiveCameraScreen() :postWidget(),)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:() {
                      selected.value = 0;
                      _pickVideo();
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

  Widget postWidget(){
    return Column(
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
                        MyTextWidget(data: "Upload photos here",)],
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
    );
  }

  Widget liveWidget(){
    return Padding(
      padding: const EdgeInsets.only(top: 380),
      child: MyTextWidget(data: "You can Go Live", size: 20, color: fieldBorderColor, weight: FontWeight.w600,),
    );
  }

  Future<void> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
        _videoFile = File(pickedFile.path);
    }
  }

  Future<void> _recordVideo() async {
    final XFile? recordedFile = await _picker.pickVideo(source: ImageSource.camera);

    if (recordedFile != null) {
        _videoFile = File(recordedFile.path);
    }
  }
}
