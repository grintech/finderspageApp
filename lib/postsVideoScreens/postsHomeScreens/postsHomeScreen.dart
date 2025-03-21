import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/util.dart';

import '../../utils/routes.dart';

class Postshomescreen extends StatelessWidget {
  Postshomescreen({super.key});

  final _currentIndex = 0.obs;

  final List<String> productImages = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF7303030),
      appBar: AppBar(
        backgroundColor: blackColor,
        surfaceTintColor: blackColor,
        leading: GestureDetector(
          onTap: () => Get.offAllNamed(Routes.homeRoute),
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
              Row(
                children: [
                  Icon(Icons.notifications_none_outlined, color: whiteColor,size: 30,),
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
      body: ListView.builder(
        padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 20),
        itemCount: 4,
          itemBuilder: (context, index){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ImageView(
                            height: 40, width: 40,
                            margin: EdgeInsets.only(right: 15),
                          ),
                          MyTextWidget(data: "John", size: 15, color: whiteColor,)
                        ],
                      ),
                      Icon(Icons.more_vert, color: whiteColor,)
                    ],
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 500,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      _currentIndex.value = index;
                    },
                  ),
                  items:
                  productImages.map((imagePath) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePath,
                          width: Get.width,
                          height: 500,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: productImages.asMap().entries.map((entry) {
                    int index = entry.key;
                    return Obx(()=>Container(
                      width: _currentIndex.value == index ? 10 : 10,
                      height: 10,
                      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                        _currentIndex.value == index
                            ? fieldBorderColor
                            : whiteColor
                      ),
                    ));
                  }).toList(),
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
          }),
    );
  }
}
