import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/postCreateScreen.dart';
import 'package:projects/postsVideoScreens/postsHomeScreens/postsHomeScreen.dart';
import 'package:projects/postsVideoScreens/postsProfileScreens/postProfileScreen.dart';
import 'package:projects/postsVideoScreens/shortsListScreens/miniWidget.dart';
import 'package:projects/postsVideoScreens/shortsListScreens/shortsListScreen.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/util.dart';

import '../postSearchScreens/postSearchScreen.dart';

class PostsNavBarScreen extends StatelessWidget {
  PostsNavBarScreen({super.key});

  final controller = Get.put(PostsHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body:Obx(()=>IndexedStack(
        index: controller.tabIndex.value,
        children: [
          Postshomescreen(),
          Container(),
          PostCreateScreen(),
          PostSearchScreen(),
          PostProfileScreen()
        ],
      ),),
      // GetBuilder<PostsHomeController>(builder: (_){
      //   return IndexedStack(
      //     index: controller.tabIndex.value,
      //     children: [
      //       Postshomescreen(),
      //       VideoFeedScreen(),
      //       PostCreateScreen(),
      //       PostSearchScreen(),
      //       PostProfileScreen()
      //     ],
      //   );
      // }),
      bottomNavigationBar: Container(
        height: 55,
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: blackColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  controller.changeTabIndex(0);
                },
                child: Icon(Icons.home, color: whiteColor,size: 30,)
              ),

              GestureDetector(
                  onTap: () => controller.changeTabIndex(1),
                  child: Image.asset("assets/images/ic_mini.png",
                    color: whiteColor, height: 30, width: 30,)),

              GestureDetector(
                onTap: () {
                  controller.changeTabIndex(2);
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Icon(Icons.add, color: blackColor,))
              ),
              GestureDetector(
                onTap: () {
                  controller.changeTabIndex(3);
                },
                child: Icon(Icons.search, color: fieldBorderColor, size: 30,)
              ),

              GestureDetector(
                onTap: () {
                  controller.changeTabIndex(4);
                },
                child: Icon(Icons.person, color: whiteColor, size: 30,)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
