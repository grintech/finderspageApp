import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/postsVideoScreens/postCreateScreen/postCreateScreen.dart';
import 'package:projects/screens/Events/event_calendar.dart';
import 'package:projects/screens/Profile/aboutScreen.dart';
import 'package:projects/screens/Profile/profile.dart';
import 'package:projects/screens/authScreens/login.dart';
import 'package:projects/screens/homeScreens/home_page.dart';
import 'package:projects/screens/homeScreens/notifications.dart';
import 'package:projects/screens/homeScreens/trendingScreen.dart';

import '../../controllers/homeController.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>IndexedStack(
        index: controller.tabIndex.value,
        children: [
          HomePage(),
          TrendingScreen(),
          PostCreateScreen(),
          AboutScreen(),
          Login(),
        ],
      ),),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                controller.changeTabIndex(0);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/home-icon.png',
                    color: Colors.black,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Home",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                controller.changeTabIndex(1);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/ic_trending.png',
                    color: Colors.black,
                    height: 25,
                    width: 25,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Popular",
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ],
              ),
            ),

            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: IconButton(
                icon: Icon(Icons.add, size: 35, color: Colors.white),
                onPressed: () {
                  controller.changeTabIndex(2);
                },
              ),
            ),

            GestureDetector(
              onTap: () {
                controller.changeTabIndex(3);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/ic_about.png',
                    color: Colors.black,
                    height: 25,
                    width: 25,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "About",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                controller.changeTabIndex(4);
              },
              child:
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Image.asset(
              //       'assets/images/profile-icon.png',
              //       color: Colors.black,
              //       height: 25,
              //       width: 25,
              //     ),
              //     SizedBox(height: 4),
              //     Text(
              //       "Profile",
              //       style: TextStyle(fontSize: 12, color: Colors.black),
              //     ),
              //   ],
              // ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/logout-icon.png",
                    color: Colors.black,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
