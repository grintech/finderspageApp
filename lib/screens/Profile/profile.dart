import 'package:flutter/material.dart';
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
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/arrow.png',
              width: 25,
              height: 25,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 23),

          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 48.5, // Half of 97px
                  backgroundImage: AssetImage('assets/images/profile-pic.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.editProfileRoute);
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
          SizedBox(height: 8),

          Text(
            "John Smith",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 28),

          // Stats Row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBoxItem("45", "Photos"),
                _buildBoxItem("500", "Followers"),
                _buildBoxItem("200", "Following"),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Profile Options
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
                  callback: () { },
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
                  callback: () {},
                ),
                _buildProfileOption(
                  "assets/images/logout-icon.png",
                  "Logout",
                  isLogout: false,
                  callback: () {
                    Navigator.pushNamed(context, Routes.homeRoute);
                  },
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.homeRoute);
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

            // Calendar
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/events',
                ); 
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

            // Center Floating Button
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
                  Navigator.pushNamed(context, '/create');
                },
              ),
            ),

            // Create List
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/create-list',
                ); 
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

            // Profile
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/profile',
                );
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
