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

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({super.key});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  File? _videoFile;
  RxnString imgUrl = RxnString();
  final selected = 0.obs;
  late CreatePostController imagePickerController;

  List<String> tabs = ["Video", "Mini", "Live", "Post"];

  final captionController = TextEditingController();
  final descController = TextEditingController();
  final locController = TextEditingController();

  void _scrollToSelected(int index) {
    double itemWidth = 80; // Approx width for each item (adjust if needed)

    _scrollController.animateTo(
      (itemWidth + 20) * index - (200 / 2) + (itemWidth / 2),
      // 200 is container width
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize controller on screen load
    imagePickerController = Get.put(CreatePostController());
  }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Obx(() => selected.value == 0
          ? VideoPickerScreen(from: "upload")
          : selected.value == 1
          ? CustomCameraScreen()
          : selected.value == 2
          ? LiveCameraScreen()
          : UploadPostScreen(from: "create")),

      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 50, right: 50, bottom: 10),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: fieldBorderColor, width: 2),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: tabs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  selected.value = index;
                  _scrollToSelected(index);

                  if (index == 3) {
                    imagePickerController.resetData();
                  }
                },
                child: Obx(()=>Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  child: MyTextWidget(
                    data: tabs[index],
                    size: 15,
                    weight: FontWeight.w600,
                    color: selected.value == index
                        ? fieldBorderColor
                        : blackColor,
                  ),
                ),)
              );
            },
          )
      ),
    );
  }

}

