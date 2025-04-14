import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postProfileController.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/data/apiConstants.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/postCreateScreen.dart';
import 'package:projects/postsVideoScreens/postsHomeScreens/postsHomeScreen.dart';
import 'package:projects/postsVideoScreens/postsHomeScreens/postsVideoScreen.dart';
import 'package:projects/postsVideoScreens/postsProfileScreens/postProfileScreen.dart';
import 'package:projects/postsVideoScreens/shortsListScreens/miniWidget.dart';
import 'package:projects/postsVideoScreens/shortsListScreens/shortsListScreen.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/util.dart';

import '../postSearchScreens/postSearchScreen.dart';

class PostsNavBarScreen extends StatefulWidget {
  const PostsNavBarScreen({super.key});

  @override
  State<PostsNavBarScreen> createState() => _PostsNavBarScreenState();
}

class _PostsNavBarScreenState extends State<PostsNavBarScreen> with TickerProviderStateMixin {
  late PostsHomeController controller = Get.put(PostsHomeController());

  @override
  void initState() {
    super.initState();
    controller = Get.find<PostsHomeController>();
    controller.tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body:Obx(() {
        switch (controller.tabIndex.value) {
          case 0:
            return Postshomescreen();
          case 1:
            return PostVideoScreen();
          case 2:
            return PostCreateScreen();
          case 3:
            return PostSearchScreen();
          case 4:
            return PostProfileScreen();
          default:
            return Container();
        }
      }),
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
                child:
                // Icon(Icons.person, color: fieldBorderColor, size: 30,)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: StorageHelper().getUserModel()?.user?.image != null
                      ?Image.network(
                    height: 25, width: 25, fit: BoxFit.fill,
                    "${ApiConstants.profileUrl}/${StorageHelper().getUserModel()?.user?.image}",
                  ):ImageView(height: 25,width: 25,),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
