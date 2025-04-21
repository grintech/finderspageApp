import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/data/apiConstants.dart';
import 'package:projects/data/models/PostsListModel.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/mediaWidget.dart';

import '../../utils/helper/dateHelper.dart';
import '../../utils/helper/storageHelper.dart';
import '../../utils/imageViewer.dart';
import '../../utils/util.dart';
import '../shortsListScreens/shortsListScreen.dart';

class PostVideoScreen extends StatelessWidget {
  PostVideoScreen({super.key});

  final controller = Get.put(PostsHomeController());
  final PageController _pageController = PageController();

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
          alignment: Alignment.bottomRight,
          children: [
            MediaWidget(mediaUrl: mediaUrl, screenRatio: 0.9,),
            SingleChildScrollView(
              child: Obx(()=>Column(
                children: [
                  GestureDetector(
                      onTap: () async {
                        final currentUserId = StorageHelper().getUserModel()?.user?.id?.toString();
                        if (currentUserId == null) return;

                        final post = controller.videoList[index];

                        // Decode the likedBy JSON string to Map<String, dynamic>
                        Map<String, dynamic> likedByMap = {};
                        try {
                          likedByMap = post.likedBy != null ? json.decode(post.likedBy!) : {};
                        } catch (e) {
                          likedByMap = {};
                        }

                        final alreadyLiked = likedByMap.containsKey(currentUserId);
                        final actionToSend = alreadyLiked ? "unlike" : "like";
                        int currentLikes = int.tryParse(post.likes ?? '0') ?? 0;

                        if (alreadyLiked) {
                          likedByMap.remove(currentUserId);
                          currentLikes = (currentLikes - 1).clamp(0, double.infinity).toInt();
                        } else {
                          likedByMap[currentUserId] = "1";
                          currentLikes += 1;
                        }

                        post.likedBy = json.encode(likedByMap); // ✅ Fix
                        post.likes = currentLikes.toString();

                        controller.videoList[index] = post;
                        controller.videoList.refresh();
                        controller.postLikeApi(PostsListModel(
                          user_id: int.parse(currentUserId),
                          blog_id: post.id,
                          cate_id: 3,
                          action: actionToSend,
                          type: "Blogs-Feed",
                          url: "https://www.finderspage.com/single-new/${post.slug}",
                          reaction: "1",
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Icon(CupertinoIcons.hand_thumbsup, size: 33,
                              color: Colors.white,
                            ),
                            MyTextWidget(
                              data: "${controller.videoList[index].likes}",
                              color: whiteColor,
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 25),
                  GestureDetector(
                      onTap: () async {
                        await controller.getCommentsLists(controller.videoList[index].id!);
                        showCommentBox();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Icon(CupertinoIcons.chat_bubble_text, size: 33,
                              color: Colors.white,
                            ),
                            MyTextWidget(
                              data: "${controller.videoList[index].total_comments}",
                              color: whiteColor,
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Icon(CupertinoIcons.arrow_turn_up_right, size: 33,
                          color: Colors.white,
                        ),
                        MyTextWidget(
                          data: "Share", color: whiteColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                ],
              ),)
            )
          ],
        );
      },
    );
  }

  Future<dynamic> showCommentBox() {
    return showModalBottomSheet(
        isDismissible: false,
        context: Get.context!,
        builder: (context) {
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
                      controller.commentList.isNotEmpty?
                      MyTextWidget(data: "Comments ${controller.commentList.length}", size: 14, weight: FontWeight.w600,):
                      MyTextWidget(data: "Comment", size: 14, weight: FontWeight.w600,),
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(CupertinoIcons.multiply))
                    ],
                  ),
                ),
                controller.commentList.isNotEmpty?
                Expanded(
                  child: ListView.builder(
                      itemCount: controller.commentList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    controller.commentList[index].image != null?
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network( height: 20, width: 20, fit: BoxFit.fill,
                                            "${ApiConstants.profileUrl}/${controller.commentList[index].image}"),
                                      ),
                                    ):
                                    ImageView(
                                      height: 20, width: 20,
                                      margin: EdgeInsets.only(right: 8),
                                    ),
                                    MyTextWidget(data: "@${controller.commentList[index].username}", size: 12, weight: FontWeight.w500,),
                                    SizedBox(width: 8,),
                                    MyTextWidget(data: DateHelper().convertToTimeAgo(controller.commentList[index].updatedAt!), size: 10, weight: FontWeight.w400,),
                                  ],
                                ),
                                Icon(Icons.more_vert)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, top: 6, bottom: 8),
                              child: MyTextWidget(data: "${controller.commentList[index].comment}",size: 12,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Row(
                                children: [
                                  Icon(Icons.thumb_up_alt_outlined, size: 18,),
                                  SizedBox(width: 8,),
                                  Icon(
                                    Icons.thumb_down_alt_outlined, size: 18,),
                                  SizedBox(width: 8,),
                                  Icon(Icons.message_outlined, size: 18,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, top: 8, bottom: 15),
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
                ):Padding(
                  padding:EdgeInsets.only(top: 40),
          child: Text("No Comments yet"),),
              ],
            ),
          );
        }
    );
  }
}