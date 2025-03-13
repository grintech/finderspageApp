import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/postCreateScreen.dart';
import 'package:projects/postsVideoScreens/postsHomeScreens/postsHomeScreen.dart';
import 'package:projects/utils/colorConstants.dart';

class PostsNavBarScreen extends StatelessWidget {
  PostsNavBarScreen({super.key});

  final controller = Get.put(PostsHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Obx(()=>IndexedStack(
        index: controller.tabIndex.value,
        children: [
          Postshomescreen(),
          PostCreateScreen(),
          Container(
            child: Text("Notifications"),
          ),
          Container(
            child: Text("Profile"),
          )
        ],
      ),),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 25, top: 10),
        decoration: BoxDecoration(
          color: blackColor,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
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
                child: Icon(Icons.home, color: whiteColor,)
              ),

              GestureDetector(
                onTap: () {
                  controller.changeTabIndex(1);
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Icon(Icons.add, color: blackColor,))
              ),
              GestureDetector(
                onTap: () {
                  controller.changeTabIndex(2);
                },
                child: Icon(Icons.search, color: whiteColor,)
              ),

              GestureDetector(
                onTap: () {
                  controller.changeTabIndex(3);
                },
                child: Icon(Icons.person, color: whiteColor,)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
