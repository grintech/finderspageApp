import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/screens/Events/event_calendar.dart';
import 'package:projects/screens/Profile/profile.dart';
import 'package:projects/screens/homeScreens/home_page.dart';
import 'package:projects/screens/homeScreens/notifications.dart';

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
          EventCalendar(),
          Notifications(),
          Profile()
        ],
      ),),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
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
          MainAxisAlignment.spaceEvenly,
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
                    'assets/images/calendar-icon.png',
                    color: Colors.black,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Calendar",
                    style: TextStyle(fontSize: 12, color: Colors.black),
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
                onPressed: () {},
              ),
            ),

            GestureDetector(
              onTap: () {
                controller.changeTabIndex(2);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/newpost-icon.png',
                    color: Colors.black,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Create List",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
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
                    'assets/images/profile-icon.png',
                    color: Colors.black,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Profile",
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
