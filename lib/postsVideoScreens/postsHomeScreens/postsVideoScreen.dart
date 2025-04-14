import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/data/apiConstants.dart';
import 'package:projects/utils/commonWidgets/mediaWidget.dart';

import '../../utils/imageViewer.dart';
import '../../utils/util.dart';
import '../shortsListScreens/shortsListScreen.dart';

class PostVideoScreen extends StatelessWidget {
  PostVideoScreen({super.key});

  final controller = Get.put(PostsHomeController());
  final PageController _pageController = PageController();

  var like = true.obs;
  var disLike = true.obs;
  var comment = true.obs;
  var share = true.obs;

  @override
  Widget build(BuildContext context) {
    // controller.getVideoLists();
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: controller.videoList.length,
      itemBuilder: (context, index) {
        final post = controller.videoList[index];

        // Decode the JSON-encoded string
        List<String> videos = [];
        try {
          videos = List<String>.from(jsonDecode(post.postVideo));
        } catch (e) {
          // fallback in case of bad format
          videos = [];
        }

        if (videos.isEmpty) {
          return const SizedBox(); // or some placeholder
        }

        final mediaUrl = "${ApiConstants.postImgUrl}/${videos.first}";
        return Stack(
          children: [
            MediaWidget(mediaUrl: mediaUrl, screenRatio:0.9,),
            buildPosLikeComment()
          ],
        );
      },
    );
  }
  Future<dynamic> showCommentBox(){
    return showModalBottomSheet(
        isDismissible: false,
        context: Get.context!,
        builder: (context){
          return Container(
            height: 400,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTextWidget(data: "Comment 5", size: 14, weight: FontWeight.w600,),
                      GestureDetector(
                          onTap: () {
                              Get.back();
                          },
                          child: Icon(CupertinoIcons.multiply))
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ImageView(
                                      height: 20, width: 20,
                                      margin: EdgeInsets.only(right: 8),
                                    ),
                                    MyTextWidget(data: "@FilmyUpdates",),
                                    MyTextWidget(data: " 10 hrs ago",),
                                  ],
                                ),
                                Icon(Icons.more_vert)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, top: 6, bottom: 8),
                              child: MyTextWidget(data: "Awesome Video",),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Row(
                                children: [
                                  Icon(Icons.thumb_up_alt_outlined, size: 18,),
                                  SizedBox(width: 8,),
                                  Icon(Icons.thumb_down_alt_outlined, size: 18,),
                                  SizedBox(width: 8,),
                                  Icon(Icons.message_outlined, size: 18,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, top: 8, bottom: 15),
                              child: Row(
                                children: [
                                  MyTextWidget(data: "5 Replies",),
                                  Icon(Icons.keyboard_arrow_right, size: 18,)
                                ],
                              ),
                            )
                          ],
                        );
                      }
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  Positioned buildPosLikeComment() {
    return Positioned(
        bottom: 0,
        right: 10,
        width: 50,
        height: 360,
        child: likeShareCommentSave());
  }
  Obx likeShareCommentSave() {

    return Obx(()=>Column(
      children: [
        GestureDetector(
            onTap: () {
              like.value = !like.value;
              disLike.value = true;
            },
            child: like.value
                ?iconDetail(CupertinoIcons.hand_thumbsup, '354k')
                :iconDetail(CupertinoIcons.hand_thumbsup_fill, "355k")),
        const SizedBox(height: 25),
        GestureDetector(
            onTap: () {
              disLike.value = !disLike.value;
              like.value = true;
            },
            child: disLike.value?iconDetail(CupertinoIcons.hand_thumbsdown, 'Dislike')
                :iconDetail(CupertinoIcons.hand_thumbsdown_fill, 'Dislike')),
        const SizedBox(height: 25),
        GestureDetector(
            onTap: () {
              comment.value = false;
              showCommentBox();
            },
            child: iconDetail(CupertinoIcons.chat_bubble_text, '872')),
        const SizedBox(height: 25),
        iconDetail(CupertinoIcons.arrow_turn_up_right, 'Share'),
      ],
    ));
  }
}
