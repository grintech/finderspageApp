import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/util.dart';

import '../../utils/colorConstants.dart';
import '../../utils/routes.dart';

class PostProfileScreen extends StatelessWidget {
  const PostProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
         Padding(
           padding: const EdgeInsets.only(right: 20),
           child: Icon(Icons.menu, color: whiteColor, size: 30,),
         )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      height: 200,
                      width: Get.width,
                      child: Image.asset("assets/images/no_image.png", fit: BoxFit.fill,),
                    ),
                    Positioned(
                      right: 12, bottom: 50,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                            ),
                          ),
                          child: Image.asset(
                            "assets/images/edit-icon.png",
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  left: 20,
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset("assets/images/user_img.png", height: 100, fit: BoxFit.fill,),
                      ),
                      Positioned(
                        bottom: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                              ),
                            ),
                            child: Image.asset(
                              "assets/images/edit-icon.png",
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: MyTextWidget(data: "@username(Web Developer)", size: 14, weight: FontWeight.w600,),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: "24",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: blackColor)
                      ),
                      TextSpan(
                          text: " My Connections",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: blackColor)
                      ),
                    ]
                  ))
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextWidget(data: "Posts", size: 12, weight: FontWeight.w500,),
                  MyTextWidget(data: "Videos",size: 12, weight: FontWeight.w400,),
                  MyTextWidget(data: "Business",size: 12, weight: FontWeight.w400,),
                  Row(
                    children: [
                      MyTextWidget(data: "Ads",size: 12, weight: FontWeight.w400,),
                      SizedBox(width: 8,),
                      Icon(Icons.keyboard_arrow_down, size: 18,)
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
                itemCount: 8,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 20),
                shrinkWrap: true,
                itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset("assets/images/user_img.png", height: 100, fit: BoxFit.fill,),
                              ),
                              MyTextWidget(data: "John Doe", size: 12, weight: FontWeight.w500,)
                            ],
                          ),
                          Icon(Icons.more_vert, size: 20,)
                        ],
                      ),
                    ),
                    Container(
                      decoration:BoxDecoration(
                        color: Colors.grey.shade200
                      ),
                        child: Image.asset("assets/images/image1.png", height: 150,
                          width: Get.width, fit: BoxFit.contain,))
                  ],
                ),
              );
            })
            // MyTextWidget(data: "No content is published yet",),
          ],
        ),
      ),
    );
  }
}
