import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/data/apiConstants.dart';
import 'package:projects/data/models/PostsListModel.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/mediaWidget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../data/models/comReplyModel.dart';
import '../../data/models/commentListModel.dart';
import '../../data/models/commentModel.dart';
import '../../utils/commonWidgets/commonTextField.dart';
import '../../utils/helper/dateHelper.dart';
import '../../utils/helper/storageHelper.dart';
import '../../utils/imageViewer.dart';
import '../../utils/util.dart';
import '../postCreateScreen/videoPreviewScreen.dart';
import '../shortsListScreens/shortsListScreen.dart';

class PostVideoScreen extends StatelessWidget {
  PostVideoScreen({super.key});

  final controller = Get.put(PostsHomeController());
  final PageController _pageController = PageController();

  final videoCommentController = TextEditingController();
  var selectVideoReply = Rx<Map<String, String?>>({});

  var share = true.obs;
  var more = true.obs;

  var showReactionBar = false.obs;
  final currentUserId = StorageHelper().getUserModel()?.user?.id?.toString();

  @override
  Widget build(BuildContext context) {
    controller.getVideoLists();
    return
      // Scaffold(
      // backgroundColor: blackColor,
      // body:GetBuilder<PostsHomeController>(
      //   builder: (controller) {
      //     controller.getVideoLists();
      //     if (controller.videoList.isEmpty) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //
      //     return Stack(
      //       children: [
      //         PageView.builder(
      //           itemCount: controller.videoList.length,
      //           scrollDirection: Axis.vertical,
      //           onPageChanged: (index) {
      //             controller.preloadNext(index);
      //           },
      //           itemBuilder: (context, index) {
      //             final post = controller.videoList[index];
      //             final mediaUrl = controller.videoUrls[index]; // or build from post.postVideo
      //             final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
      //             return FutureBuilder<VideoPlayerController>(
      //               future: controller.getController(index),
      //               builder: (context, snapshot) {
      //                 if (!snapshot.hasData || !snapshot.data!.value.isInitialized) {
      //                   return const Center(child: CircularProgressIndicator());
      //                 }
      //                 return buildMediaWidget(snapshot.data!, mediaUrl, isPortrait);
      //               },
      //             );
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // ),
      //
      //
      // );




      PageView.builder(
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

          // final mediaUrl = "${ApiConstants.postImgUrl}/${videos.first}";
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: MediaWidget(mediaUrl: "${ApiConstants.postImgUrl}/${videos.first}", screenRatio: 1,),
              ),
              Positioned(
                bottom:50,
                right: 10,
                child: Stack(
                  children: [
                    Column(
                      children: [
                       Obx(()=> GestureDetector(
                           onTap: () async {
                             final currentUserId = StorageHelper().getUserModel()?.user?.id?.toString();
                             if (currentUserId != null) {
                               controller.updateVideoLike(post, currentUserId);
                             }
                           },
                           onLongPress: (){
                             showReactionBar.value = !showReactionBar.value;
                           },
                           child: Padding(
                             padding: const EdgeInsets.only(right: 10, bottom: 10),
                             child: Column(
                               children: [
                                 Image.asset(
                                   getReactionIconPath(post, StorageHelper().getUserModel()?.user?.id?.toString()),
                                   height: 33,
                                   width: 33,
                                 ),
                                 MyTextWidget(
                                   data: "${controller.videoList[index].likes??""}",
                                   color: whiteColor,
                                 ),
                               ],
                             ),
                           )),),
                        const SizedBox(height: 15),
                        Obx(()=>GestureDetector(
                            onTap: () async {
                              await controller.getCommentsLists(controller.videoList[index].id!);
                              await controller.fetchRepliesForAllComments();
                              showModalBottomSheet(
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  backgroundColor: whiteColor,
                                  context: Get.context!,
                                  builder: (context) {
                                    return StatefulBuilder(builder: (context, setState){
                                      final ScrollController _scrollController = ScrollController();
                                      return Padding(
                                        padding: EdgeInsets.only(left: 20, right:20, top: 12, bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              height: 300,
                                              padding: EdgeInsets.only(bottom: 40),
                                              color: whiteColor,
                                              child: Column(
                                                children: [
                                                  Obx(() {
                                                    return Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        controller.commentList.isNotEmpty
                                                            ? MyTextWidget(data: "Comments ${controller.commentList.length}", size: 14, weight: FontWeight.w600)
                                                            : MyTextWidget(data: "Comment", size: 14, weight: FontWeight.w600),
                                                        GestureDetector(
                                                          onTap: () {
                                                            selectVideoReply.value = {};
                                                            Get.back();
                                                          },
                                                          child: Icon(CupertinoIcons.multiply, size: 30),
                                                        ),
                                                      ],
                                                    );
                                                  }),

                                                  Obx(() {
                                                    return controller.commentList.isNotEmpty
                                                        ? Expanded(
                                                      child: ListView.builder(
                                                        reverse: true,
                                                        controller: _scrollController,
                                                        itemCount: controller.commentList.length,
                                                        itemBuilder: (context, index) {
                                                          final commentId = controller.commentList[index].id!;
                                                          final replies = controller.replyMap[commentId] ?? [];
                                                          return GestureDetector(
                                                            onTapDown: (TapDownDetails details) async {
                                                              final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                                                              await showMenu(
                                                                context: context,
                                                                position: RelativeRect.fromLTRB(
                                                                  details.globalPosition.dx, // horizontal
                                                                  details.globalPosition.dy, // vertical (top of the tap)
                                                                  overlay.size.width - details.globalPosition.dx,
                                                                  overlay.size.height - details.globalPosition.dy,
                                                                ),
                                                                color: whiteColor,
                                                                items: [
                                                                  // Define the delete option in the menu
                                                                  PopupMenuItem(
                                                                    height: 30,
                                                                    value: 0,
                                                                    onTap: () {
                                                                      final commentId = controller.commentList[index].id!;
                                                                      final postId = controller.postsList[index].id!;
                                                                      controller.getDeleteVideoComment(commentId, postId);
                                                                      Get.back();
                                                                    },
                                                                    child: SizedBox(
                                                                      width: 120,
                                                                      child: Row(
                                                                        children: [
                                                                          Icon(CupertinoIcons.delete, color: Colors.red, size: 22),
                                                                          SizedBox(width: 8),
                                                                          MyTextWidget(data: "Delete", size: 12),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                            child: SizedBox(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      controller.commentList[index].image != null
                                                                          ? Padding(
                                                                        padding: const EdgeInsets.only(right: 8),
                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(20),
                                                                          child: Image.network(
                                                                            "${ApiConstants.profileUrl}/${controller.commentList[index].image}",
                                                                            height: 20,
                                                                            width: 20,
                                                                            fit: BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      )
                                                                          : ImageView(
                                                                        height: 20, width: 20, margin: EdgeInsets.only(right: 8),
                                                                      ),
                                                                      MyTextWidget(data: "@${controller.commentList[index].username}", size: 12, weight: FontWeight.w500),
                                                                      SizedBox(width: 8),
                                                                      MyTextWidget(data: DateHelper().convertToTimeAgo(controller.commentList[index].updatedAt!), size: 10, weight: FontWeight.w400),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(left: 25, top: 6, bottom: 8),
                                                                    child: MyTextWidget(data: "${controller.commentList[index].comment}", size: 12),
                                                                  ),
                                                                  Obx(() {
                                                                    return GestureDetector(
                                                                      onTap: () async {
                                                                        final currentUserId = StorageHelper().getUserModel()?.user?.id.toString();
                                                                        if (currentUserId == null) return;

                                                                        final comment = controller.commentList[index];
                                                                        List<String> likedByList = [];

                                                                        try {
                                                                          likedByList = List<String>.from(json.decode(comment.likedBy ?? '[]'));
                                                                        } catch (e) {
                                                                          likedByList = [];
                                                                        }

                                                                        bool isLiked = likedByList.contains(currentUserId);
                                                                        int currentLikes = comment.likes ?? 0;

                                                                        if (isLiked) {
                                                                          likedByList.remove(currentUserId);
                                                                          currentLikes = (currentLikes - 1).clamp(0, double.infinity).toInt();
                                                                        } else {
                                                                          likedByList.add(currentUserId);
                                                                          currentLikes += 1;
                                                                        }

                                                                        // Update comment object
                                                                        comment.likedBy = json.encode(likedByList);
                                                                        comment.likes = currentLikes;

                                                                        // Refresh comment list
                                                                        controller.commentList[index] = comment;
                                                                        controller.commentList.refresh();

                                                                        // Send to API
                                                                        await controller.likeComment(CommentListModel(
                                                                          userId: currentUserId,
                                                                          comment_id: comment.id,
                                                                          action: isLiked ? "unlike" : "like",
                                                                        ));
                                                                      },
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.only(left: 25),
                                                                        child: Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.thumb_up_alt_outlined,
                                                                              size: 18,
                                                                              color: fieldBorderColor,
                                                                            ),
                                                                            SizedBox(width: 6),
                                                                            MyTextWidget(data: "${controller.commentList[index].likes}"),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                  Padding(
                                                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap: () {
                                                                            selectVideoReply.value = {
                                                                              'commentId': controller.commentList[index].id.toString(),
                                                                              'username': controller.commentList[index].username
                                                                            };
                                                                          },
                                                                          child: MyTextWidget(data: "Reply", size: 12),
                                                                        ),
                                                                        replies.isNotEmpty
                                                                            ? GestureDetector(
                                                                          onTap: () {
                                                                            controller.getComReplyLists(commentId);
                                                                          },
                                                                          child: Row(
                                                                            children: [
                                                                              Container(height: 1, width: 60, color: greyColor),
                                                                              SizedBox(width: 10),
                                                                              MyTextWidget(
                                                                                data: replies.length < 2 ? "View ${replies.length} reply" : "View ${replies.length} replies",
                                                                                size: 14,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                            : SizedBox(),
                                                                        replies.isNotEmpty
                                                                            ? Column(
                                                                          children: List.generate(replies.length, (replyIndex) {
                                                                            final reply = replies[replyIndex];
                                                                            return Padding(
                                                                              padding: const EdgeInsets.only(left: 25, top: 8),
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  reply.image != null
                                                                                      ? ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    child: Image.network(
                                                                                      "${ApiConstants.profileUrl}/${reply.image}",
                                                                                      height: 20,
                                                                                      width: 20,
                                                                                      fit: BoxFit.fill,
                                                                                    ),
                                                                                  )
                                                                                      : ImageView(height: 20, width: 20),
                                                                                  SizedBox(width: 8),
                                                                                  Expanded(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        MyTextWidget(data: "@${reply.username}", size: 12, weight: FontWeight.w600),
                                                                                        MyTextWidget(data: reply.comment ?? '', size: 12),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        )
                                                                            : SizedBox(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 20,)
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                        : Padding(
                                                      padding: EdgeInsets.only(top: 40),
                                                      child: Text("No Comments yet"),
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                            Obx(()=>Container(
                                              height: 50,
                                              margin: EdgeInsets.only(bottom: 20),
                                              color: whiteColor,
                                              child: CommonTextField(
                                                height: 50,
                                                textController: videoCommentController,
                                                prefix: selectVideoReply.value['username'] != null
                                                    ? IntrinsicWidth(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 4),
                                                    child: Row(
                                                      children: [
                                                        MyTextWidget(data:"@${selectVideoReply.value['username']}", size: 12,),
                                                        SizedBox(width: 4,),
                                                        GestureDetector(
                                                            onTap: (){
                                                              selectVideoReply.value = {};
                                                            },
                                                            child: Icon(Icons.close, size: 16, color: fieldBorderColor,))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                    :null,
                                                hint: "Post Comment",
                                                suffix: IconButton(onPressed: ()async{
                                                  if (videoCommentController.text.trim().isEmpty) return;
                                                  if (selectVideoReply.value['username'] != null){
                                                    controller.replyPostApi(ComReplyModel(
                                                        comment_id: selectVideoReply.value['commentId'],
                                                        blog_id: controller.videoList[index].id.toString(),
                                                        blog_user_id: controller.videoList[index].user_id.toString(),
                                                        user_id: StorageHelper().getUserModel()?.user?.id.toString(),
                                                        type: controller.postsList[index].type,
                                                        blog_url: "https://www.finderspage.com/single-new/${controller.postsList[index].slug}",
                                                        comment: videoCommentController.text.trim().toString()
                                                    ));
                                                  }else {
                                                    controller.commentPostApi(CommentModel(
                                                            comment: videoCommentController.text.trim().toString(),
                                                            post_id: controller.videoList[index].id.toString(),
                                                            post_user: controller.videoList[index].user_id.toString(),
                                                            user_id: StorageHelper().getUserModel()?.user?.id.toString(),
                                                            type: controller.videoList[index].type=="video"?"video":"posts",
                                                        ));
                                                    selectVideoReply.value = {};
                                                    videoCommentController.clear();
                                                    await controller.getCommentsLists(controller.videoList[index].id!);  // <--- Fetch updated comments
                                                    controller.commentList.refresh();// 🚫 Don't call Get.back() here! (Don't close the bottom sheet)
                                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                                      _scrollController.animateTo(
                                                        0,
                                                        duration: Duration(milliseconds: 300),
                                                        curve: Curves.easeOut,
                                                      );
                                                    });
                                                    // Get.back();
                                                  }
                                                },
                                                    icon: Icon(Icons.send, size: 25,
                                                      color: fieldBorderColor,)),
                                              ),
                                            ))
                                          ],
                                        ),
                                      );
                                    });
                                  }
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Icon(CupertinoIcons.chat_bubble_text, size: 33,
                                    color: Colors.white,
                                  ),
                                  MyTextWidget(
                                    data: controller.videoList[index].total_comments!=0?
                                    "${controller.videoList[index].total_comments}":"",
                                    color: whiteColor,
                                  ),
                                ],
                              ),
                            )),),
                        const SizedBox(height: 25),
                        GestureDetector(
                          onTap: () {
                            Share.share("https://www.finderspage.com/single-new/${controller.videoList[index].slug}");
                          },
                          child: Padding(
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
                        ),
                        const SizedBox(height: 25),
                        StorageHelper().getUserModel()?.user?.id != controller.videoList[index].user_id?
                        PopupMenuButton<int>(
                            color: whiteColor,
                            surfaceTintColor: whiteColor,
                            icon: Icon(Icons.more_vert, color: whiteColor, size: 20,),
                            offset: Offset(-30, -35),
                            menuPadding: EdgeInsets.zero,
                            itemBuilder: (context){
                              return <PopupMenuEntry<int>>[
                                PopupMenuItem(value: 0,child: Text("Report"),),
                              ];
                            }) :
                        PopupMenuButton<int>(
                            color: whiteColor,
                            surfaceTintColor: whiteColor,
                            icon: Icon(Icons.more_vert, color: whiteColor, size: 20,),
                            offset: Offset(-30, -80),
                            menuPadding: EdgeInsets.zero,
                            itemBuilder: (context){
                              return <PopupMenuEntry<int>>[
                                PopupMenuItem(
                                  onTap: (){
                                    final video = controller.videoList[index];
                                    Get.to(VideoPickerScreen(
                                      from: "edit",
                                      videoId: video.id.toString(),
                                      caption: video.title,
                                      description: video.description,
                                      location: video.location,
                                      mediaUrl: videos.first,
                                    )
                                    );
                                  },
                                  value: 0,
                                  child: Text("Edit"),),
                                PopupMenuItem(
                                  onTap: (){
                                    controller.deletePostApi(controller.postsList[index].id!);
                                  },
                                  value: 1,
                                  child: Text("Delete"),
                                ),
                              ];
                            })
                      ],
                    ),
                    Obx(()=>showReactionBar.value?
                    Positioned(
                      right: 10, top: 20,
                      child: ReactionBar(
                        onSelect: (reactionType) async {
                          showReactionBar.value = false;
                          controller.update();

                          final currentUserId = StorageHelper().getUserModel()?.user?.id?.toString();
                          if (currentUserId == null) return;

                          Map<String, dynamic> likedByMap = {};
                          try {
                            if (post.liked_by is String) {
                              final likedByString = post.liked_by as String;
                              if (likedByString.trim().startsWith('{')) {
                                final decoded = json.decode(likedByString);
                                if (decoded is Map<String, dynamic>) {
                                  likedByMap = decoded;
                                }
                              }
                            } else if (post.liked_by is Map) {
                              likedByMap = Map<String, dynamic>.from(post.liked_by as Map);
                            }
                          } catch (_) {}

                          bool alreadyLiked = likedByMap.containsKey(currentUserId);
                          int currentLikes = int.tryParse(post.likes ?? '0') ?? 0;

                          if (!alreadyLiked) {
                            // New like
                            currentLikes += 1;
                          }

                          // Always update reaction (even if already liked)
                          likedByMap[currentUserId] = reactionType;
                          post.likes = currentLikes.toString();
                          post.liked_by = likedByMap.map((k, v) => MapEntry(k, v.toString()));

                          // Update local list
                          final index = controller.videoList.indexWhere((p) => p.id == post.id);
                          if (index != -1) {
                            controller.videoList[index] = post;
                            controller.videoList.refresh();
                          }

                          // Call like API
                          await controller.videoLikeApi(
                            PostsListModel(
                              user_id: int.parse(currentUserId),
                              blog_id: post.id,
                              cate_id: 727,
                              action: "like",
                              type: "video",
                              url: "https://www.finderspage.com/single-new/${post.slug}",
                              reaction: reactionType,
                            ),
                          );
                        },
                      ),):SizedBox())
                  ],
                ),
              ),
              Positioned(
                bottom: 20,left: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(()=>controller.videoList[index].userImage == null?
                        ImageView(
                          height: 40, width: 40,
                          margin: EdgeInsets.only(right: 15),
                          image: controller.videoList[index].userImage,
                        ):Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ClipRRect(borderRadius: BorderRadius.circular(50),
                              child: Image.network("${ApiConstants.profileUrl}/${controller.videoList[index].userImage}",
                                width: 40, height: 40,fit: BoxFit.fill,)),
                        ),),

                        Obx(()=>MyTextWidget(data: "${controller.videoList[index].userName}", size: 15, color: whiteColor, weight: FontWeight.w600,))
                      ],
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                        width: 280,
                        child:Obx(()=> GestureDetector(
                          onTap: () {
                            more.value = !more.value;
                          },
                          child: more.value?
                          MyTextWidget(data: "${controller.videoList[index].description}", size: 14,
                            color: whiteColor, overflow: TextOverflow.ellipsis,):MyTextWidget(data: "${controller.videoList[index].description}", size: 14,
                              color: whiteColor),
                        )))
                  ],
                ),
              ),
            ],
          );
        },
      );
  }
  // Widget buildMediaWidget(VideoPlayerController controller, String mediaUrl, bool isPortrait) {
  //   final lowerUrl = mediaUrl.toLowerCase();
  //   final videoSize = controller.value.size;
  //   final isVideo = lowerUrl.endsWith(".mp4") || lowerUrl.endsWith(".mov") || lowerUrl.endsWith(".avi");
  //   final isPortrait = videoSize.height > videoSize.width;
  //   return GestureDetector(
  //     onTap: () {
  //       if (controller.value.isPlaying) {
  //         controller.pause();
  //       } else {
  //         controller.play();
  //       }
  //     },
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         isVideo
  //             ? (isPortrait
  //             ? SizedBox(
  //           width: Get.width,
  //           height: Get.width * (videoSize.height / videoSize.width),
  //           child: VideoPlayer(controller),
  //         )
  //             : Center(
  //           child: FittedBox(
  //             fit: BoxFit.contain,
  //             child: SizedBox(
  //               width: videoSize.width,
  //               height: videoSize.height,
  //               child: VideoPlayer(controller),
  //             ),
  //           ),
  //         ))
  //             : Image.network(
  //           mediaUrl,
  //           width: Get.width,
  //           fit: BoxFit.cover,
  //           errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
  //         ),
  //         if (!controller.value.isPlaying)
  //           const Icon(
  //             Icons.play_arrow,
  //             size: 64,
  //             color: Colors.white70,
  //           ),
  //       ],
  //     ),
  //   );
  // }
  String getReactionIconPath(dynamic post, String? userId) {
    if (post.liked_by == null || userId == null) return "assets/images/ic_like.png";

    try {
      final likedByMap = post.liked_by is String
          ? Map<String, dynamic>.from(json.decode(post.liked_by))
          : Map<String, dynamic>.from(post.liked_by);
      final reaction = likedByMap[userId];

      // Handle different reactions
      if (reaction == "1") return "assets/reactions/ic_heart.png";  // Heart reaction
      if (reaction == "2") return "assets/reactions/ic_thumb.png";  // Thumb reaction
      if (reaction == "0" || reaction == "") return "assets/images/ic_like.png";  // No reaction (unliked or empty)

    } catch (_) {}

    return "assets/images/ic_like.png";  // Default like icon
  }

}

class ReactionBar extends StatelessWidget {
  final Function(String) onSelect;
  const ReactionBar({required this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => onSelect("1"),
              child: Image.asset("assets/reactions/ic_heart.png", height: 22, width: 22),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => onSelect("2"),
              child: Image.asset("assets/reactions/ic_thumb.png", height: 22, width: 22),
            ),
            // Add more reactions here...
          ],
        ),
      ),
    );
  }
}