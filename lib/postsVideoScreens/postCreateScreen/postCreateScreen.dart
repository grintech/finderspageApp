import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/util.dart';

import '../../utils/colorConstants.dart';
import '../../utils/helper/cameraHelper.dart';

class PostCreateScreen extends StatelessWidget{
  PostCreateScreen({super.key});

  // late CameraHelper cameraHelper;
  RxnString imgUrl = RxnString();

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
        ],
      ),
    );
  }

  @override
  void onSuccessFile(String selectedUrl, String fileType) {
    imgUrl.value = selectedUrl;
  }

  @override
  void onSuccessVideo(String selectedUrl, Uint8List? thumbnail) {
    // TODO: implement onSuccessVideo
  }
}
