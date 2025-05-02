import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/data/models/PostsListModel.dart';
import 'package:projects/data/models/comReplyModel.dart';
import 'package:projects/data/models/commentListModel.dart';
import 'package:projects/data/models/commentModel.dart';
import 'package:projects/data/models/likeModel.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/uploadPostScreen.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/videoPreviewScreen.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/helper/dateHelper.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/util.dart';
import 'package:share_plus/share_plus.dart';

import '../../controllers/postsHomeController.dart';
import '../../data/apiConstants.dart';
import '../../utils/commonWidgets/mediaWidget.dart';
import '../../utils/routes.dart';

class Postshomescreen extends StatelessWidget {
  Postshomescreen({super.key});
  final controller =Get.lazyPut(() => PostsHomeController());

  RxBool isLiked = RxBool(false);

  final commentController = TextEditingController();

  var selectReply = Rx<Map<String, String?>>({});

  var more = true.obs;
  var showReactionBar = false.obs;
  final currentUserId = StorageHelper().getUserModel()?.user?.id?.toString();
  @override
  Widget build(BuildContext context) {

    return GetBuilder<PostsHomeController>(builder: (controller){
      controller.getPostLists();
      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xF7303030),
          appBar: AppBar(
            backgroundColor: blackColor,
            surfaceTintColor: blackColor,
            leading: GestureDetector(
              // onTap: () => Get.offAllNamed(Routes.homeRoute),
              child: Padding(
                padding: const EdgeInsets.only(top: 6, left: 10, bottom: 6),
                child: Image.asset(
                  "assets/images/new_logo.png",
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // MyTextWidget(
                  //   data: "Back to main",
                  //   size: 12, color: whiteColor,
                  // ),
                  // SizedBox(width: 130,),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.notificationApi(StorageHelper().getUserId()!);
                          },
                          child: Icon(Icons.notifications_none_outlined,
                            color: whiteColor,size: 30,)),
                      Padding(
                          padding: const EdgeInsets.only(left: 15, right: 20),
                          child: Image.asset("assets/images/ic_chat.png", height: 25, width: 25, color: fieldBorderColor,)
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          body: Obx(()=>ListView.builder(
              padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 20),
              controller: controller.scrollController,
              itemCount: controller.postsList.length,
              itemBuilder: (context, index) {
                if (index == controller.postsList.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final post = controller.postsList[index];
                final imageList = post.imageList;
                final imageData = controller.postsList[index].imageList ?? [];
                final currentIndex = RxInt(0);
                return GestureDetector(
                  onTap: (){
                    showReactionBar.value=false;
                  },
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Obx(()=>controller.postsList[index].userImage == null?
                                    ImageView(
                                      height: 40, width: 40,
                                      margin: EdgeInsets.only(right: 15),
                                      image: controller.postsList[index].userImage,
                                    ):Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: ClipRRect(borderRadius: BorderRadius.circular(50),
                                          child: Image.network("${ApiConstants.profileUrl}/${controller.postsList[index].userImage}",
                                            width: 40, height: 40,fit: BoxFit.fill,)),
                                    ),),
                                    Obx(()=>MyTextWidget(data: "${controller.postsList[index].userName}", size: 15, color: whiteColor,)
                                    )
                                  ],
                                ),
                                StorageHelper().getUserModel()?.user?.id != controller.postsList[index].user_id?
                                PopupMenuButton<int>(
                                    color: whiteColor,
                                    surfaceTintColor: whiteColor,
                                    icon: Icon(Icons.more_vert, color: whiteColor, size: 20,),
                                    offset: Offset(-12, 35),
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
                                    offset: Offset(-12, 35),
                                    menuPadding: EdgeInsets.zero,
                                    itemBuilder: (context){
                                      return <PopupMenuEntry<int>>[
                                        PopupMenuItem(
                                          onTap: (){
                                            final post = controller.postsList[index];
                                            controller.postsList[index].type == "video"?
                                            Get.to(()=>VideoPickerScreen(
                                              from: "edit",
                                              videoId: post.id.toString(),
                                              caption: post.title,
                                              description: post.description,
                                              location: post.location,
                                              mediaUrl: post.postVideo,
                                            )
                                            ):
                                            Get.to(UploadPostScreen(
                                              from: "edit",
                                              postId: post.id.toString(),
                                              caption: post.description,
                                              location: post.location,
                                              existingMedia: post.imageList,
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
                          ),
                          Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 400,
                                  enableInfiniteScroll: false,
                                  scrollPhysics: imageData.length > 1
                                      ? const BouncingScrollPhysics()
                                      : const NeverScrollableScrollPhysics(),
                                  viewportFraction: 1.0,
                                  onPageChanged: (index, reason) {
                                    currentIndex.value = index;
                                  },
                                ),
                                items: controller.postsList[index].imageList!.map((fileName) {
                                  final mediaUrl = "${ApiConstants.postImgUrl}/$fileName";
                                  return
                                    // Container();
                                    MediaWidget(mediaUrl: mediaUrl, screenRatio: 0.7,);
                                }).toList(),
                              ),
                              imageList!.length>1?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  List.generate(
                                    imageList.length, (index) {
                                  return Obx(() => Container(
                                    width: 10,
                                    height: 10,
                                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentIndex.value == index ? fieldBorderColor : whiteColor,
                                    ),
                                  ));
                                }),
                              ):SizedBox(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Obx(()=> Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
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

                                    final alreadyLiked = likedByMap.containsKey(currentUserId);

                                    if (alreadyLiked) {
                                      // Remove like
                                      likedByMap.remove(currentUserId);
                                      int currentLikes = (int.tryParse(post.likes ?? '0') ?? 0) - 1;
                                      post.likes = currentLikes.clamp(0, double.infinity).toInt().toString();
                                      post.liked_by = likedByMap.map((k, v) => MapEntry(k, v.toString()));

                                      // Update local list
                                      final index = controller.postsList.indexWhere((p) => p.id == post.id);
                                      if (index != -1) {
                                        controller.postsList[index] = post;
                                        controller.postsList.refresh();
                                      }

                                      // Call unlike API
                                      await controller.postLikeApi(
                                        PostsListModel(
                                          user_id: int.parse(currentUserId),
                                          blog_id: post.id,
                                          cate_id: 3,
                                          action: "unlike",
                                          blog_user_id: post.user_id.toString(),
                                          type: "Blogs-Feed",
                                          url: "https://www.finderspage.com/single-new/${post.slug}",
                                          reaction: "", // No reaction on unlike
                                        ),
                                      );
                                    }

                                    controller.update();
                                  },
                                  onLongPress: () {
                                    showReactionBar.value = !showReactionBar.value;
                                    controller.update();
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        getReactionIconPath(post, StorageHelper().getUserModel()?.user?.id?.toString()),
                                        height: 22,
                                        width: 22,
                                        color: getReactionIconPath(post, currentUserId).contains('ic_like.png')
                                            ? fieldBorderColor
                                            : null,
                                      ),
                                      const SizedBox(width: 6),
                                      MyTextWidget(
                                        data: post.likes ?? "",
                                        size: 16, color: fieldBorderColor,
                                        weight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),

                                GestureDetector(
                                  onTap: ()async{
                                    await controller.getCommentsLists(controller.postsList[index].id!);
                                    await controller.fetchRepliesForAllComments();
                                    showModalBottomSheet(
                                        isDismissible: false,
                                        isScrollControlled: true,
                                        backgroundColor: whiteColor,
                                        context: Get.context!,
                                        builder: (context){
                                          return StatefulBuilder(builder: (context,setState){
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
                                                       Obx(()=> Padding(
                                                         padding: const EdgeInsets.symmetric(vertical: 10),
                                                         child: Row(
                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                           children: [
                                                             controller.commentList.isNotEmpty?
                                                             MyTextWidget(data: "Comments ${controller.commentList.length}", size: 14, weight: FontWeight.w600,):
                                                             MyTextWidget(data: "Comment", size: 14, weight: FontWeight.w600,),
                                                             GestureDetector(
                                                                 onTap: () {
                                                                   selectReply.value = {};
                                                                   Get.back();
                                                                 },
                                                                 child: Icon(CupertinoIcons.multiply, size: 30,))
                                                           ],
                                                         ),
                                                       ),),
                                                        Obx(()=>controller.commentList.isNotEmpty?
                                                        Expanded(
                                                          child: ListView.builder(
                                                              reverse: true,
                                                              controller: _scrollController,
                                                              itemCount: controller.commentList.length,
                                                              padding: EdgeInsets.only(bottom: 20),
                                                              itemBuilder: (context, index){
                                                                final commentId = controller.commentList[index].id!;
                                                                final replies = controller.replyMap[commentId] ?? [];
                                                                return SizedBox(
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      GestureDetector(
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
                                                                              // PopupMenuItem(
                                                                              //   height: 30,
                                                                              //   value: 0,
                                                                              //   onTap: (){
                                                                              //     commentController.text = controller.commentList[index].comment!;
                                                                              //     controller.commentEditApi(commentId,
                                                                              //         CommentModel(
                                                                              //           editedComment: commentController.text.trim().toString()
                                                                              //         ));
                                                                              //   },
                                                                              //   child: SizedBox(
                                                                              //     width: 120,
                                                                              //     child: Row(
                                                                              //       children: [
                                                                              //         Image.asset("assets/images/ic_edit.png", scale: 25, color: fieldBorderColor,),
                                                                              //         SizedBox(width: 10),
                                                                              //         MyTextWidget(data: "Edit", size: 12,),
                                                                              //       ],
                                                                              //     ),
                                                                              //   ),
                                                                              // ),
                                                                              PopupMenuItem(
                                                                                height: 30,
                                                                                value: 0,
                                                                                onTap: (){
                                                                                  controller.getDeleteComment(controller.commentList[index].id!);
                                                                                  Get.back();
                                                                                },
                                                                                child: SizedBox(
                                                                                  width: 120,
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Icon(CupertinoIcons.delete, color: Colors.red, size: 22,),
                                                                                      SizedBox(width: 8),
                                                                                      MyTextWidget(data: "Delete", size: 12,),
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
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 25, top: 6, bottom: 8),
                                                                                child: MyTextWidget(data: "${controller.commentList[index].comment}",size: 12,),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      //Like Comment
                                                                      Obx(() => GestureDetector(
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

                                                                          bool isLiked = likedByList.contains(currentUserId); // Check if the current user has liked the comment
                                                                          int currentLikes = comment.likes ?? 0;

                                                                          if (isLiked) {
                                                                            // Unlike
                                                                            likedByList.remove(currentUserId);
                                                                            currentLikes = (currentLikes - 1).clamp(0, double.infinity).toInt();
                                                                          } else {
                                                                            // Like
                                                                            likedByList.add(currentUserId);
                                                                            currentLikes += 1;
                                                                          }

                                                                          // Update comment object
                                                                          comment.likedBy = json.encode(likedByList);
                                                                          comment.likes = currentLikes;

                                                                          setState(() {
                                                                            // Reflect the like/unlike action locally
                                                                            controller.commentList[index] = comment;
                                                                            controller.commentList.refresh();
                                                                          });

                                                                          // Send to API
                                                                          await controller.likeComment(
                                                                            CommentListModel(
                                                                              userId: currentUserId,
                                                                              comment_id: comment.id,
                                                                              action: isLiked ? "unlike" : "like",
                                                                            ),
                                                                          );
                                                                        },
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.only(left: 25),
                                                                          child: Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.thumb_up_alt_outlined ,
                                                                                size: 18,
                                                                                color: fieldBorderColor,  // Change color when liked
                                                                              ),
                                                                              SizedBox(width: 6),
                                                                              MyTextWidget(
                                                                                data: "${controller.commentList[index].likes}",
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )),

                                                                      //Reply UI
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                                                                        child: Column(
                                                                          mainAxisAlignment:MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            GestureDetector(
                                                                                onTap:(){
                                                                                  selectReply.value = {
                                                                                    'commentId': controller.commentList[index].id.toString(),
                                                                                    'username': controller.commentList[index].username
                                                                                  };
                                                                                },
                                                                                child: MyTextWidget(data: "Reply", size: 12,)),
                                                                            replies.isNotEmpty
                                                                                ? GestureDetector(
                                                                              onTap: () {
                                                                                controller.getComReplyLists(commentId);
                                                                              },
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(height: 1, width: 60, color: greyColor,),
                                                                                  SizedBox(width: 10,),
                                                                                  MyTextWidget(data: replies.length<2?"View ${replies.length} reply"
                                                                                      :"View ${replies.length} replies", size: 14),
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
                                                                                          : ImageView(
                                                                                        height: 20,
                                                                                        width: 20,
                                                                                      ),
                                                                                      SizedBox(width: 8),
                                                                                      Expanded(
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            MyTextWidget(
                                                                                              data: "@${reply.username}",
                                                                                              size: 12,
                                                                                              weight: FontWeight.w600,
                                                                                            ),
                                                                                            MyTextWidget(
                                                                                              data: reply.comment ?? '',
                                                                                              size: 12,
                                                                                            ),
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
                                                                );
                                                              }
                                                          ),
                                                        )
                                                            :Padding(
                                                          padding:EdgeInsets.only(top: 40),
                                                          child: Text("No Comments yet"),),),
                                                      ],
                                                    ),
                                                  ),
                                                  Obx(()=>Container(
                                                    height: 50,
                                                    margin: EdgeInsets.only(bottom: 20, top: 20),
                                                    color: whiteColor,
                                                    child: CommonTextField(
                                                      height: 50,
                                                      textController: commentController,
                                                      prefix: selectReply.value['username'] != null
                                                          ? IntrinsicWidth(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 4),
                                                              child: Row(
                                                            children: [
                                                              MyTextWidget(data:"@${selectReply.value['username']}", size: 12,),
                                                              SizedBox(width: 4,),
                                                              GestureDetector(
                                                                  onTap: (){selectReply.value = {};
                                                                  },
                                                                  child: Icon(Icons.close, size: 16, color: fieldBorderColor,))
                                                            ],
                                                              ),
                                                            ),
                                                          )
                                                          :null,
                                                      hint: "Post Comment",
                                                      suffix: IconButton(onPressed: ()async{
                                                        if (commentController.text.trim().isEmpty) return;

                                                        if (selectReply.value['username'] != null) {
                                                          await controller.replyPostApi(ComReplyModel(
                                                            comment_id: selectReply.value['commentId'],
                                                            blog_id: controller.postsList[index].id.toString(),
                                                            blog_user_id: controller.postsList[index].user_id.toString(),
                                                            user_id: StorageHelper().getUserModel()?.user?.id.toString(),
                                                            type: controller.postsList[index].type,
                                                            blog_url: "https://www.finderspage.com/single-new/${controller.postsList[index].slug}",
                                                            comment: commentController.text.trim(),
                                                          ));
                                                        } else {
                                                          await controller.commentPostApi(CommentModel(
                                                            comment: commentController.text.trim(),
                                                            post_id: controller.postsList[index].id.toString(),
                                                            post_user: controller.postsList[index].user_id.toString(),
                                                            user_id: StorageHelper().getUserModel()?.user?.id.toString(),
                                                            type: controller.postsList[index].type=="video"?"video":"posts",
                                                          ));
                                                        }

                                                        // ✅ Clear inputs, update list
                                                        commentController.clear();
                                                        selectReply.value = {};
                                                        await controller.getCommentsLists(controller.postsList[index].id!);  // <--- Fetch updated comments
                                                        controller.commentList.refresh();// 🚫 Don't call Get.back() here! (Don't close the bottom sheet)
                                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                                          _scrollController.animateTo(
                                                            double.parse("${controller.postsList[index]}"),
                                                            duration: Duration(milliseconds: 300),
                                                            curve: Curves.easeOut,
                                                          );
                                                        });
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
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 5),
                                          child: Image.asset("assets/images/ic_message.png", height: 20, width: 20, color: fieldBorderColor),
                                        ),
                                        MyTextWidget(data: controller.postsList[index].total_comments != 0
                                            ?"${controller.postsList[index].total_comments}":"", size: 18, weight: FontWeight.w500, color: fieldBorderColor,)
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Share.share("https://www.finderspage.com/single-new/${controller.postsList[index].slug}");
                                    },
                                    child: Icon(Icons.share, color: fieldBorderColor,)),
                              ],
                            ),),
                          ),
                          controller.postsList[index].description != null && controller.postsList[index].description!.isNotEmpty?
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyTextWidget(data: "${controller.postsList[index].userName}", size: 12, color: whiteColor, weight: FontWeight.w600,),
                                SizedBox(width: 12,),
                                Flexible(child: Obx(()=>GestureDetector(
                                  onTap: () {
                                    more.value = !more.value;
                                  },
                                  child: more.value?MyTextWidget(data: "${controller.postsList[index].description}", size: 12,
                                    color: whiteColor, weight: FontWeight.w400, overflow: TextOverflow.ellipsis,):MyTextWidget(data: "${controller.postsList[index].description}", size: 12,
                                      color: whiteColor, weight: FontWeight.w400),
                                ))),
                              ],
                            ),
                          ):SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: MyTextWidget(
                                  size: 12, color: whiteColor, weight: FontWeight.w400,
                                  data: "${DateHelper().convertToTimeAgo(controller.postsList[index].modified!)} ago",)),
                          )
                        ],
                      ),
                     Obx(()=> showReactionBar.value?
                     Positioned(
                       bottom: 50, // place above the button
                       left: 0,
                       child:ReactionBar(
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
                           final index = controller.postsList.indexWhere((p) => p.id == post.id);
                           if (index != -1) {
                             controller.postsList[index] = post;
                             controller.postsList.refresh();
                           }

                           // Call like API
                           await controller.postLikeApi(
                             PostsListModel(
                               user_id: int.parse(currentUserId),
                               blog_id: post.id,
                               cate_id: 3,
                               action: "like",
                               blog_user_id: post.user_id.toString(),
                               type: "Blogs-Feed",
                               url: "https://www.finderspage.com/single-new/${post.slug}",
                               reaction: reactionType,
                             ),
                           );
                         },
                       ),
                     ):SizedBox())
                    ],
                  ),
                );
              }),)
      );
    });
  }


  String getReactionIconPath(dynamic post, String? userId) {
    if (post.liked_by == null || userId == null) return "assets/images/ic_like.png";

    try {
      final likedByMap = post.liked_by is String
          ? Map<String, dynamic>.from(json.decode(post.liked_by))
          : Map<String, dynamic>.from(post.liked_by);
      final reaction = likedByMap[userId];
      if (reaction == "1") return "assets/reactions/ic_heart.png";
      if (reaction == "2") return "assets/reactions/ic_thumb.png";
    } catch (_) {}

    return "assets/images/ic_like.png";
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => onSelect("1"),
              child: Image.asset("assets/reactions/ic_heart.png", height: 22, width: 22),
            ),
            const SizedBox(width: 12),
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

