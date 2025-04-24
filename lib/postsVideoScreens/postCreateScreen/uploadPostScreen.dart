import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../controllers/createPostController.dart';
import '../../data/apiConstants.dart';
import '../../data/models/videoUploadModel.dart';
import '../../utils/colorConstants.dart';
import '../../utils/commonWidgets/commonButton.dart';
import '../../utils/commonWidgets/commonTextField.dart';
import '../../utils/util.dart';

class UploadPostScreen extends StatelessWidget {
  UploadPostScreen({super.key, required this.from, this.postId, this.userId, this.category, this.caption, this.location, this.type, this.description, this.existingMedia});

  late final String from;
  late String? postId;
  late String? userId;
  late String? category;
  late String? caption;
  late String? location;
  late String? type;
  late String? description;
  final List<String>? existingMedia;




  final CreatePostController imagePickerController = Get.put(CreatePostController());

  var shareOn = false.obs;
  var likesOn = false.obs;
  var commentOn = false.obs;
  var donationOn = false.obs;


  @override
  Widget build(BuildContext context) {
    if (from == "edit" && existingMedia != null) {
      imagePickerController.prefillFields(caption, location);
      imagePickerController.setEditMedia(existingMedia!);
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusScopeNode());
      },
      child: Obx(() => SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: from == "edit"?20:70, right: 20, top: 20, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  from == "edit"?GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.arrow_back_ios, color: fieldBorderColor,)):
                  const SizedBox(),
                  MyTextWidget(data:from == "edit"?"Edit Post": "Create New Post"),
                  CommonButton(
                    onPressed: () async {
                      // final files = imagePickerController.selectedFiles;
                      // final fileNames = files.map((f) => path.basename(f.path)).toList();

                      List<String> fileNames = [];

// Add existing media (file names only)
                      fileNames.addAll(imagePickerController.existingNetworkMedia);

// Add new files (extract just file names from File path)
                      fileNames.addAll(
                        imagePickerController.selectedFiles.map((file) => file.path.split('/').last),
                      );

                      List<File> files = imagePickerController.selectedFiles;

                      final uploadModel = VideoUploadModel(
                        description: imagePickerController.captionController.text,
                        location: imagePickerController.locController.text,
                        shares: shareOn.value ? 1 : 0,
                        commentOption: commentOn.value ? 1 : 0,
                        likesBtn: likesOn.value ? "1" : "0",
                        donationLink: imagePickerController.donationController.text,
                        categories: "3",
                        type: "post&video",
                        image1: jsonEncode(fileNames), // ✅ All file names (new + old)
                        id: imagePickerController.storageHelper.getUserModel()?.user!.id,
                        selectedFiles: files,          // ✅ Only new files for multipart
                      );
                      from == "edit"?
                          imagePickerController.editPostApi(uploadModel, int.parse("$postId")):
                      imagePickerController.uploadPost(uploadModel);
                    },
                    btnTxt: from =="edit"? "Update":"Share",
                    radius: 6,
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                  )
                ],
              ),
            ),

            GestureDetector(
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
                      height: 150,
                      child: imagePickerController.selectedFiles.isEmpty && imagePickerController.existingNetworkMedia.isEmpty
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/ic_upload.png", scale: 2),
                          MyTextWidget(data: "Upload photos or videos here"),
                        ],
                      )
                          : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(10),
                        itemCount: imagePickerController.selectedFiles.length + imagePickerController.existingNetworkMedia.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          // Show network images first
                          if (index < imagePickerController.existingNetworkMedia.length) {
                            final imageUrl = '${ApiConstants.postImgUrl}/'+imagePickerController.existingNetworkMedia[index];
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    imageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      imagePickerController.existingNetworkMedia.removeAt(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red.withOpacity(0.8),
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      child: const Icon(Icons.close, color: Colors.white, size: 15),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            final file = imagePickerController.selectedFiles[index - imagePickerController.existingNetworkMedia.length];
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: isVideo(file.path)
                                      ? Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.black,
                                    child: const Center(child: Icon(Icons.videocam, color: Colors.white)),
                                  )
                                      : Image.file(
                                    file,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      imagePickerController.selectedFiles.removeAt(index - imagePickerController.existingNetworkMedia.length);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red.withOpacity(0.8),
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      child: const Icon(Icons.close, color: Colors.white, size: 15),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),

                    ),
                  ),
                ),
              ),
            ),

            CommonTextField(margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
              hint: "Add Caption Here...", lines: 3, length: 150,
              keyboardAction: TextInputAction.newline, textController: imagePickerController.captionController,),
            imagePickerController.isLimitReached.value?
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextWidget(data: "* Limit reached. Get 25,000 characters with Premium. Just \$6.88/mon or \$58/year.",
                  color: Colors.red, size: 10, weight: FontWeight.w600,
                ),
              ),
            ):SizedBox(),

            CommonTextField(margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
              hint: "Add Location", textController: imagePickerController.locController,),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextWidget(data: "Share",size: 14, weight: FontWeight.w400,),
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
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextWidget(data: "Comment",size: 14, weight: FontWeight.w400,),
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
              padding: const EdgeInsets.symmetric( vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextWidget(data: "Likes",size: 14, weight: FontWeight.w400,),
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
              padding: const EdgeInsets.symmetric( vertical: 8, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextWidget(data: "Would you allow tips or donations?", size: 14, weight: FontWeight.w500,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTextWidget(data: "Tips & Donation (Optional)", size: 14, weight: FontWeight.w400,),
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
                ],
              ),
            ),
            Obx(()=>Visibility(
                visible: donationOn.value,
                child: CommonTextField(
                  hint: "Your Payment Link",
                  margin: EdgeInsets.symmetric(horizontal: 20),
                )))
          ],
        ),
      )
      ),
    );
  }

  bool isVideo(String path) {
    final ext = path.toLowerCase();
    return ext.endsWith(".mp4") || ext.endsWith(".mov") || ext.endsWith(".avi") || ext.endsWith(".mkv");
  }
}

