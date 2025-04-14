import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/util.dart';

import '../../data/apiConstants.dart';
import '../../utils/commonWidgets/mediaWidget.dart';
import '../../utils/routes.dart';

class Postshomescreen extends StatelessWidget {
  Postshomescreen({super.key});

  final controller =Get.lazyPut(() => PostsHomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsHomeController>(builder: (controller){
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
                          Row(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Image.asset("assets/images/ic_like.png", height: 22, width: 22, color: fieldBorderColor,)
                                  ),
                                  MyTextWidget(data: "2", size: 18, weight: FontWeight.w500, color: fieldBorderColor,)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Image.asset("assets/images/ic_message.png", height: 20, width: 20, color: fieldBorderColor),
                                    ),
                                    MyTextWidget(data: "2", size: 18, weight: FontWeight.w500, color: fieldBorderColor,)
                                  ],
                                ),
                              ),
                              Icon(Icons.share, color: fieldBorderColor,),
                            ],
                          ),
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
}
