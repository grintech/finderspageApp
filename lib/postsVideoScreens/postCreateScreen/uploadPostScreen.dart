import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../controllers/createPostController.dart';
import '../../data/models/videoUploadModel.dart';
import '../../utils/colorConstants.dart';
import '../../utils/commonWidgets/commonButton.dart';
import '../../utils/commonWidgets/commonTextField.dart';
import '../../utils/util.dart';

class UploadPostScreen extends StatelessWidget {
  UploadPostScreen({super.key});

  final captionController = TextEditingController();
  final descController = TextEditingController();
  final locController = TextEditingController();
  final donationController = TextEditingController();

  final CreatePostController imagePickerController = Get.put(CreatePostController());

  var shareOn = false.obs;
  var likesOn = false.obs;
  var commentOn = false.obs;
  var donationOn = false.obs;



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 20, top: 20, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                MyTextWidget(data: "Create New Post",),
                CommonButton(
                  onPressed: ()async{
                    imagePickerController.uploadPost(VideoUploadModel(
                        description: captionController.text,
                        location: locController.text,
                        shares: shareOn.value == true?1:0,
                        commentOption: commentOn.value == true?1:0,
                        likesBtn: likesOn.value == true?"1":"0",
                        donationLink: donationController.text,
                        categories: "3",
                        type: "post&video",
                        image1: imagePickerController.selectedImagePath.value,
                        id: imagePickerController.storageHelper.getUserModel()?.user!.id
                    ));
                  },
                  btnTxt: "Next",
                  radius: 6,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                )
              ],
            ),
          ),
          Obx(()=>GestureDetector(
            onTap: () {
              Utils.mediaOptions();
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
                        child: imagePickerController.selectedImagePath.value.isEmpty
                        // && imagePickerController.playerController != null
                        // && imagePickerController.playerController!.value.isInitialized
                            ?Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/ic_upload.png", scale: 2,),
                            MyTextWidget(data: "Upload photos here",)],
                        ):
                        // :imagePickerController.selectedImagePath.value.isNotEmpty ?
                        Image.file(File(imagePickerController.selectedImagePath.value),
                          width: 180, height: 180,
                          fit: BoxFit.contain,)
                      //     :
                      // AspectRatio(
                      //   aspectRatio: 1.5,
                      //   child: VideoPlayer(imagePickerController.playerController!),
                      // ),
                    )),
              ),
            ),
          ),),
          CommonTextField(margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
            hint: "Add Caption Here...", lines: 3,
            keyboardAction: TextInputAction.newline, textController: captionController,),
          CommonTextField(margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            hint: "Add Location", textController: locController,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTextWidget(data: "Share",),
                Obx(()=>FlutterSwitch(
                  height: 20, width: 40,
                    toggleSize: 12,
                    activeColor: fieldBorderColor,
                    value: shareOn.value,
                    onToggle:(val){
                      shareOn.value = val;
                    }
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTextWidget(data: "Comment",),
                Obx(()=>FlutterSwitch(
                    height: 20, width: 40,
                    toggleSize: 12,
                    activeColor: fieldBorderColor,
                    value: commentOn.value,
                    onToggle:(val){
                      commentOn.value = val;
                    }
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTextWidget(data: "Likes",),
                Obx(()=>FlutterSwitch(
                    height: 20, width: 40,
                    toggleSize: 12,
                    activeColor: fieldBorderColor,
                    value: likesOn.value,
                    onToggle:(val){
                      likesOn.value = val;
                    }
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTextWidget(data: "Tips & Donation (Optional)",),
                Obx(()=>FlutterSwitch(
                    height: 20, width: 40,
                    toggleSize: 12,
                    activeColor: fieldBorderColor,
                    value: donationOn.value,
                    onToggle:(val){
                      donationOn.value = val;
                    }
                )),
              ],
            ),
          ),
          Obx(()=>Visibility(
              visible: donationOn.value,
              child: Column(
                children: [
                  MyTextWidget(data: "Would you like to receive tips or donations?",),
                  CommonTextField(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    height: 45,
                    textController: donationController,
                    hint: "Add Your Payment link here...",
                  ),
                ],
              )))
        ],
      ),
    );
  }
}
