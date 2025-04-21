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
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/helper/dateHelper.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/util.dart';

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

  @override
  Widget build(BuildContext context) {

    return GetBuilder<PostsHomeController>(builder: (controller){
      controller.getPostLists();
      return Scaffold(
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
                            Get.toNamed(Routes.notificationRoute);
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
              itemCount: controller.postsList.length,
              itemBuilder: (context, index){
                final post = controller.postsList[index];
                final imageList = post.imageList;
                final imageData = controller.postsList[index].imageList ?? [];
                final currentIndex = RxInt(0);
                return Column(
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
                          Icon(Icons.more_vert, color: whiteColor,)
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 500,
                            enableInfiniteScroll: imageData.length > 1,
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
                            return MediaWidget(mediaUrl: mediaUrl, screenRatio: 0.8,);
                          }).toList(),
                        ),
                        imageList!.length>1?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  List.generate(imageList.length, (index) {
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Obx(()=> Row(
                           children: [
                             GestureDetector(
                               onTap: () async {
                                 final currentUserId = StorageHelper().getUserModel()?.user?.id?.toString();
                                 if (currentUserId == null) return;

                                 final post = controller.postsList[index];

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

                                 controller.postsList[index] = post;
                                 controller.postsList.refresh();

                                 // Call the API
                                 await controller.postLikeApi(
                                   PostsListModel(
                                     user_id: int.parse(currentUserId),
                                     blog_id: post.id,
                                     cate_id: 3,
                                     action: actionToSend,
                                     type: "Blogs-Feed",
                                     url: "https://www.finderspage.com/single-new/${post.slug}",
                                     reaction: "1",
                                   ),
                                 );
                               },
                               child: Row(
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(right: 5),
                                     child: Image.asset(
                                       "assets/images/ic_like.png",
                                       height: 22,
                                       width: 22,
                                       color:  fieldBorderColor
                                     ),
                                   ),
                                   MyTextWidget(
                                     data: controller.postsList[index].likes ?? "0",
                                     size: 18,
                                     weight: FontWeight.w500,
                                     color: fieldBorderColor,
                                   )
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
                                         return DraggableScrollableSheet(
                                             initialChildSize: 0.9, // 90% of screen height
                                             minChildSize: 0.5,
                                             maxChildSize: 0.95,
                                             expand: false,
                                             builder: (_,scrollController){
                                               return Padding(
                                                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                                 child: Stack(
                                                   alignment: Alignment.bottomCenter,
                                                   children: [
                                                     Container(
                                                       padding: EdgeInsets.only(bottom: 40),
                                                       color: whiteColor,
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
                                                                       selectReply.value = {};
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
                                                                 itemBuilder: (context, index){
                                                                   final commentId = controller.commentList[index].id!;
                                                                   final replies = controller.replyMap[commentId] ?? [];
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
                                                                         ],
                                                                       ),
                                                                       Padding(
                                                                         padding: const EdgeInsets.only(left: 25, top: 6, bottom: 8),
                                                                         child: MyTextWidget(data: "${controller.commentList[index].comment}",size: 12,),
                                                                       ),
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

                                                                       Padding(
                                                                         padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                                                       )
                                                                     ],
                                                                   );
                                                                 }
                                                             ),
                                                           )
                                                               :Padding(
                                                             padding:EdgeInsets.only(top: 40),
                                                             child: Text("No Comments yet"),),
                                                         ],
                                                       ),
                                                     ),
                                                     Obx(()=>Container(
                                                       height: 50,
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
                                                                     onTap: (){
                                                                       selectReply.value = {};
                                                                     },
                                                                     child: Icon(Icons.close, size: 16, color: fieldBorderColor,))
                                                               ],
                                                                                                                          ),
                                                                                                                        ),
                                                             )
                                                             :null,
                                                         hint: "Post Comment",
                                                         suffix: IconButton(onPressed: (){
                                                           setState((){
                                                             selectReply.value['username'] != null?
                                                                 controller.replyPostApi(ComReplyModel(
                                                                   comment_id: selectReply.value['commentId'],
                                                                   blog_id: controller.postsList[index].id.toString(),
                                                                   blog_user_id: controller.postsList[index].user_id.toString(),
                                                                   user_id: StorageHelper().getUserModel()?.user?.id.toString(),
                                                                   type: "posts",
                                                                   blog_url: "https://www.finderspage.com/single-new/${controller.postsList[index].slug}",
                                                                   comment: commentController.text.trim().toString()
                                                                 )):
                                                             controller.commentPostApi(CommentModel(
                                                                 comment: commentController.text.trim().toString(),
                                                                 post_id: controller.postsList[index].id.toString(),
                                                                 post_user: controller.postsList[index].user_id.toString(),
                                                                 user_id: StorageHelper().getUserModel()?.user?.id.toString(),
                                                                 type: "posts"
                                                             ));
                                                             selectReply.value = {};
                                                             commentController.clear();
                                                             Get.back();
                                                           });
                                                         }, icon: Icon(Icons.send, size: 25, color: fieldBorderColor,)),
                                                       ),
                                                     ))
                                                   ],
                                                 ),
                                               );
                                             });
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
                                     MyTextWidget(data: "${controller.postsList[index].total_comments}", size: 18, weight: FontWeight.w500, color: fieldBorderColor,)
                                   ],
                                 ),
                               ),
                             ),
                             Icon(Icons.share, color: fieldBorderColor,),
                           ],
                         ),),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Icon(Icons.bookmark, color: whiteColor,),
                              ),
                              MyTextWidget(data: "2", size: 18, weight: FontWeight.w500, color: whiteColor,)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              }),)
      );
    });
  }
  // bool _isPostLikedByCurrentUser(PostsListModel post) {
  //   final currentUserId = StorageHelper().getUserModel()?.user?.id?.toString();
  //   if (currentUserId == null || post.likedBy == null) return false;
  //
  //   try {
  //     final likedByMap = json.decode(post.likedBy!);
  //     return likedByMap.containsKey(currentUserId);
  //   } catch (e) {
  //     return false;
  //   }
  // }



  // Future<void> showCommentBox(){
  //   return showModalBottomSheet(
  //       isDismissible: false,
  //       isScrollControlled: true,
  //       backgroundColor: whiteColor,
  //       context: Get.context!,
  //       builder: (context){
  //         return StatefulBuilder(builder: (context,setState){
  //           return DraggableScrollableSheet(
  //               initialChildSize: 0.9, // 90% of screen height
  //               minChildSize: 0.5,
  //               maxChildSize: 0.95,
  //               expand: false,
  //               builder: (_,scrollController){
  //                 return Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //                   child: Stack(
  //                     alignment: Alignment.bottomCenter,
  //                     children: [
  //                       Container(
  //                         padding: EdgeInsets.only(bottom: 40),
  //                         color: whiteColor,
  //                         child: Column(
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.symmetric(vertical: 10),
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   controller.commentList.isNotEmpty?
  //                                   MyTextWidget(data: "Comments ${controller.commentList.length}", size: 14, weight: FontWeight.w600,):
  //                                   MyTextWidget(data: "Comment", size: 14, weight: FontWeight.w600,),
  //                                   GestureDetector(
  //                                       onTap: () {
  //                                         Get.back();
  //                                       },
  //                                       child: Icon(CupertinoIcons.multiply))
  //                                 ],
  //                               ),
  //                             ),
  //                             controller.commentList.isNotEmpty?
  //                             Expanded(
  //                               child: ListView.builder(
  //                                   itemCount: controller.commentList.length,
  //                                   itemBuilder: (context, index){
  //                                     final commentId = controller.commentList[index].id!;
  //                                     final replies = controller.replyMap[commentId] ?? [];
  //                                     return Column(
  //                                       crossAxisAlignment: CrossAxisAlignment.start,
  //                                       children: [
  //                                         Row(
  //                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                           children: [
  //                                             Row(
  //                                               children: [
  //                                                 controller.commentList[index].image != null?
  //                                                 Padding(
  //                                                   padding: const EdgeInsets.only(right: 8),
  //                                                   child: ClipRRect(
  //                                                     borderRadius: BorderRadius.circular(20),
  //                                                     child: Image.network( height: 20, width: 20, fit: BoxFit.fill,
  //                                                         "${ApiConstants.profileUrl}/${controller.commentList[index].image}"),
  //                                                   ),
  //                                                 ):
  //                                                 ImageView(
  //                                                   height: 20, width: 20,
  //                                                   margin: EdgeInsets.only(right: 8),
  //                                                 ),
  //                                                 MyTextWidget(data: "@${controller.commentList[index].username}", size: 12,),
  //                                                 SizedBox(width: 8,),
  //                                                 MyTextWidget(data: "10 h",),
  //                                               ],
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         Padding(
  //                                           padding: const EdgeInsets.only(left: 25, top: 6, bottom: 8),
  //                                           child: MyTextWidget(data: "${controller.commentList[index].comment}",size: 12,),
  //                                         ),
  //                                         GestureDetector(
  //                                           onTap:(){
  //                                             final currentUserId = StorageHelper().getUserModel()?.user?.id.toString();
  //                                             final comment = controller.replyList[index];
  //
  //                                             // Parse liked_by string into a List<String>
  //                                             List<String> likedByList = [];
  //                                             if (comment.liked_by != null && comment.liked_by!.isNotEmpty) {
  //                                               likedByList = List<String>.from(json.decode(comment.liked_by!));
  //                                             }
  //
  //                                             // Check if current user already liked
  //                                             bool isLiked = likedByList.contains(currentUserId);
  //
  //                                             if (isLiked) {
  //                                               // Unlike
  //                                               likedByList.remove(currentUserId);
  //                                               comment.likes = (comment.likes ?? 1) - 1;
  //                                             } else {
  //                                               // Like
  //                                               likedByList.add(currentUserId!);
  //                                               comment.likes = (comment.likes ?? 0) + 1;
  //                                             }
  //
  //                                             // Update liked_by field as JSON string
  //                                             comment.liked_by = json.encode(likedByList);
  //
  //                                             // Notify the UI
  //                                             controller.replyList[index] = comment;
  //                                             controller.update(); // If using GetX
  //                                           },
  //                                           child: Padding(
  //                                             padding: const EdgeInsets.only(left: 25),
  //                                             child: Row(
  //                                               children: [
  //                                                 Icon(Icons.thumb_up_alt_outlined, size: 18,),
  //                                                 SizedBox(width: 6,),
  //                                                 MyTextWidget(data: "${controller.commentList[index].likes}",),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         Padding(
  //                                           padding: const EdgeInsets.symmetric(vertical: 8.0),
  //                                           child: Column(
  //                                             mainAxisAlignment:MainAxisAlignment.start,
  //                                             crossAxisAlignment: CrossAxisAlignment.start,
  //                                             children: [
  //                                               MyTextWidget(data: "Reply", size: 12,),
  //                                               replies.isNotEmpty
  //                                                   ? GestureDetector(
  //                                                 onTap: () {
  //                                                   controller.getComReplyLists(commentId);
  //                                                 },
  //                                                 child: Row(
  //                                                   children: [
  //                                                     Container(height: 1, width: 60, color: greyColor,),
  //                                                     SizedBox(width: 10,),
  //                                                     MyTextWidget(data: replies.length<2?"View ${replies.length} reply"
  //                                                         :"View ${replies.length} replies", size: 14),
  //                                                   ],
  //                                                 ),
  //                                               )
  //                                                   : SizedBox(),
  //                                               replies.isNotEmpty
  //                                                   ? Column(
  //                                                 children: List.generate(replies.length, (replyIndex) {
  //                                                   final reply = replies[replyIndex];
  //                                                   return Padding(
  //                                                     padding: const EdgeInsets.only(left: 25, top: 8),
  //                                                     child: Row(
  //                                                       crossAxisAlignment: CrossAxisAlignment.start,
  //                                                       children: [
  //                                                         reply.image != null
  //                                                             ? ClipRRect(
  //                                                           borderRadius: BorderRadius.circular(20),
  //                                                           child: Image.network(
  //                                                             "${ApiConstants.profileUrl}/${reply.image}",
  //                                                             height: 20,
  //                                                             width: 20,
  //                                                             fit: BoxFit.fill,
  //                                                           ),
  //                                                         )
  //                                                             : ImageView(
  //                                                           height: 20,
  //                                                           width: 20,
  //                                                           margin: EdgeInsets.only(right: 8),
  //                                                         ),
  //                                                         SizedBox(width: 8),
  //                                                         Expanded(
  //                                                           child: Column(
  //                                                             crossAxisAlignment: CrossAxisAlignment.start,
  //                                                             children: [
  //                                                               MyTextWidget(
  //                                                                 data: "@${reply.username}",
  //                                                                 size: 12,
  //                                                                 weight: FontWeight.w600,
  //                                                               ),
  //                                                               MyTextWidget(
  //                                                                 data: reply.comment ?? '',
  //                                                                 size: 12,
  //                                                               ),
  //                                                             ],
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   );
  //                                                 }),
  //                                               )
  //                                                   : SizedBox(),
  //                                             ],
  //                                           ),
  //                                         )
  //                                       ],
  //                                     );
  //                                   }
  //                               ),
  //                             )
  //                                 :Padding(
  //                               padding:EdgeInsets.only(top: 40),
  //                               child: Text("No Comments yet"),),
  //                           ],
  //                         ),
  //                       ),
  //                       Container(
  //                         height: 50,
  //                         color: whiteColor,
  //                         child: CommonTextField(
  //                           height: 50,
  //                           textController: commentController,
  //                           hint: "Post Comment",
  //                           suffix: IconButton(onPressed: (){
  //                             setState((){
  //                               controller.commentPostApi(CommentModel(
  //                                   comment: commentController.text.trim().toString(),
  //                                   post_id: controller.postsList[index].id.toString(),
  //                                   post_user: controller.postsList[index].user_id.toString(),
  //                                   user_id: StorageHelper().getUserModel()?.user?.id.toString(),
  //                                   type: "posts"
  //                               ));
  //                               Get.back();
  //                             });
  //                           }, icon: Icon(Icons.send, size: 25, color: fieldBorderColor,)),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 );
  //               });
  //         });
  //       }
  //   );
  // }
}
