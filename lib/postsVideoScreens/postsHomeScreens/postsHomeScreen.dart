import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/data/models/PostsListModel.dart';
import 'package:projects/data/models/likeModel.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/util.dart';

import '../../data/apiConstants.dart';
import '../../utils/commonWidgets/mediaWidget.dart';
import '../../utils/routes.dart';

class Postshomescreen extends StatelessWidget {
  Postshomescreen({super.key});
  final controller =Get.lazyPut(() => PostsHomeController());

  var like = "like".obs;

  final commentController = TextEditingController();

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

                                 // Ensure likedBy is not null
                                 if (post.likedBy == null || post.likedBy is! Map<String, String>) {
                                   post.likedBy = {};
                                 }

                                 final alreadyLiked = post.likedBy!.containsKey(currentUserId);
                                 final actionToSend = alreadyLiked ? "unlike" : "like";

                                 int currentLikes = int.tryParse(post.likes ?? '0') ?? 0;

                                 if (alreadyLiked) {
                                   // Decrement only if already liked
                                   post.likedBy?.remove(currentUserId);
                                   currentLikes = (currentLikes - 1).clamp(0, double.infinity).toInt();
                                 } else {
                                   // Increment only if not already liked
                                   post.likedBy?[currentUserId] = "1";
                                   currentLikes += 1;
                                 }

                                 post.likes = currentLikes.toString();
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
                                       color: fieldBorderColor,
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

                                   showModalBottomSheet(
                                       isDismissible: false,
                                       isScrollControlled: true,
                                       backgroundColor: whiteColor,
                                       context: Get.context!,
                                       builder: (context){
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
                                                               return Column(
                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                 children: [
                                                                   Row(
                                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                     children: [
                                                                       Row(
                                                                         children: [
                                                                           controller.commentList[index].image!.isNotEmpty?
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
                                                                           MyTextWidget(data: "@${controller.commentList[index].username}",),
                                                                           MyTextWidget(data: " 10 hrs ago",),
                                                                         ],
                                                                       ),
                                                                       Icon(Icons.more_vert)
                                                                     ],
                                                                   ),
                                                                   Padding(
                                                                     padding: const EdgeInsets.only(left: 25, top: 6, bottom: 8),
                                                                     child: MyTextWidget(data: "${controller.commentList[index].comment}",),
                                                                   ),
                                                                   Padding(
                                                                     padding: const EdgeInsets.only(left: 25),
                                                                     child: Row(
                                                                       children: [
                                                                         Icon(Icons.thumb_up_alt_outlined, size: 18,),
                                                                         SizedBox(width: 6,),
                                                                         MyTextWidget(data: "${controller.commentList[index].likes}",),
                                                                       ],
                                                                     ),
                                                                   ),
                                                                 ],
                                                               );
                                                             }
                                                         ),
                                                       ):SizedBox(child: Text("No Comments yet"),),
                                                     ],
                                                   ),
                                                 ),
                                                 Container(
                                                   height: 50,
                                                   color: whiteColor,
                                                   child: CommonTextField(
                                                     height: 50,
                                                     textController: commentController,
                                                     hint: "Post Comment",
                                                     suffix: IconButton(onPressed: (){
                                                       Get.back();
                                                     }, icon: Icon(Icons.send, size: 25, color: fieldBorderColor,)),
                                                   ),
                                                 )
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
  // Future<dynamic> showCommentBox(){
  //   return showModalBottomSheet(
  //       isDismissible: false,
  //       context: Get.context!,
  //       builder: (context){
  //         return Container(
  //           height: 400,
  //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //           child: Column(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 10),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     MyTextWidget(data: "Comment ${controller.comment}", size: 14, weight: FontWeight.w600,),
  //                     GestureDetector(
  //                         onTap: () {
  //                             Get.back();
  //                         },
  //                         child: Icon(CupertinoIcons.multiply))
  //                   ],
  //                 ),
  //               ),
  //               Expanded(
  //                 child: ListView.builder(
  //                     itemCount: 5,
  //                     itemBuilder: (context, index){
  //                       return Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   ImageView(
  //                                     height: 20, width: 20,
  //                                     margin: EdgeInsets.only(right: 8),
  //                                   ),
  //                                   MyTextWidget(data: "@FilmyUpdates",),
  //                                   MyTextWidget(data: " 10 hrs ago",),
  //                                 ],
  //                               ),
  //                               Icon(Icons.more_vert)
  //                             ],
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 25, top: 6, bottom: 8),
  //                             child: MyTextWidget(data: "Awesome Video",),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 25),
  //                             child: Row(
  //                               children: [
  //                                 Icon(Icons.thumb_up_alt_outlined, size: 18,),
  //                                 SizedBox(width: 8,),
  //                                 Icon(Icons.thumb_down_alt_outlined, size: 18,),
  //                                 SizedBox(width: 8,),
  //                                 Icon(Icons.message_outlined, size: 18,)
  //                               ],
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 25, top: 8, bottom: 15),
  //                             child: Row(
  //                               children: [
  //                                 MyTextWidget(data: "5 Replies",),
  //                                 Icon(Icons.keyboard_arrow_right, size: 18,)
  //                               ],
  //                             ),
  //                           )
  //                         ],
  //                       );
  //                     }
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       }
  //   );
  // }
}
