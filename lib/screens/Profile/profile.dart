import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/routes.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 8),
            child: Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile-pic.png'),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.editProfileRoute);
                      },
                      child: Container(
                        width: 22,
                        height: 22,
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
                          height: 10.27,
                          width: 10.27,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Text(
            "John Smith",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBoxItem("45", "Photos"),
                _buildBoxItem("500", "Followers"),
                _buildBoxItem("200", "Following"),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              children: [
                _buildProfileOption(
                  "assets/images/user-icon.png",
                  "Account Information",
                  callback: () {},
                ),
                _buildProfileOption(
                  "assets/images/notification-icon.png",
                  "Notifications",
                  callback: () {
                    Get.toNamed(Routes.notificationRoute);
                  },
                ),
                _buildProfileOption(
                  "assets/images/active-icon.png",
                  "Active Status",
                  callback: () {},
                ),
                _buildProfileOption(
                  "assets/images/media-icon.png",
                  "Media Files",
                  callback: () {},
                ),
                _buildProfileOption(
                  "assets/images/settings-icon.png",
                  "Settings",
                  callback: () {},
                ),
                _buildProfileOption(
                  "assets/images/support-icon.png",
                  "Help & Support",
                  callback: () {},
                ),
                _buildProfileOption(
                  "assets/images/terms-icon.png",
                  "Terms & Conditions",
                  callback: () {
                    Get.toNamed(Routes.termsPrivacy);
                  },
                ),
                _buildProfileOption(
                  "assets/images/logout-icon.png",
                  "Logout",
                  isLogout: false,
                  callback: () {
                    Get.offAllNamed(Routes.loginRoute);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoxItem(String value, String label) {
    return Container(
      width: 97,
      height: 63,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildProfileOption(
    String imagePath,
    String label, {
    bool isLogout = false,
    required VoidCallback callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFEBEBEB), width: 1),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Image.asset(imagePath, width: 24, height: 24, fit: BoxFit.contain),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isLogout ? Color(0xFFDC7228) : Colors.black,
                ),
              ),
            ),
            Image.asset("assets/images/arrow-right.png", width: 16, height: 16),
          ],
        ),
      ),
    );
  }
}
