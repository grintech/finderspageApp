import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, dynamic>> categories = [
    {"icon": "assets/images/icon1.png", "label": "Jobs"},
    {"icon": "assets/images/icon2.png", "label": "Real estate"},
    {"icon": "assets/images/icon3.png", "label": "Welcome to our community"},
    {"icon": "assets/images/icon4.png", "label": "Shopping"},
    {"icon": "assets/images/icon5.png", "label": "Services"},
    {"icon": "assets/images/icon6.png", "label": "Posts & Videos"},
    {"icon": "assets/images/icon7.png", "label": "Entertainment Industry"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.3, 1.0],
                ),
               
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Finderspage',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.home, color: Colors.black),
              title: Text('Home', style: TextStyle(color: Colors.black)),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text('Settings', style: TextStyle(color: Colors.black)),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: Image.asset("assets/images/logout-icon.png"),
              title: Text('Logout', style: TextStyle(color: Colors.black)),
              onTap: () {
                Get.offAllNamed(Routes.loginRoute);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, 
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Menu Icon (Drawer)
              Builder(
                builder:
                    (context) => IconButton(
                      icon: Icon(Icons.menu, color: Colors.black),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
              ),

              // Logo (Center)
              Image.asset(
                "assets/images/new_logo.png",
                height: 41.21,
                width: 40,
              ),

              // Notification Icon (Right)
              IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  size: 24,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.notificationRoute);
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 58, 
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "Chicago",
                        style:TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8), 
                // Search Input
                Expanded(
                  child: Container(
                    height: 58, 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(
                          220,
                          114,
                          40,
                          0.17,
                        ), 
                        width: 1, 
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 10,
                              ),
                              border:
                                  InputBorder.none, 
                            ),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                          ), 
                          child: Icon(Icons.search, color: Color(0xAAA54DB7)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 35),

            // Grid Categories
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      switch (categories[index]["label"]) {
                        case "Jobs":
                          break;
                        case "Real estate":
                          break;
                        case "Welcome to our community":
                          break;
                        case "Shopping":
                          Get.toNamed(Routes.shop);
                          break;
                        case "Services":
                          break;
                        case "Blogs":
                          break;
                        case "Entertainment Industry":
                          break;
                        default:
                          // print(
                          //   "No route defined for ${categories[index]["label"]}",
                          // );
                          Get.toNamed(Routes.homeRoute);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFDC7228), Color(0xFF000000)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.4477, 0.5095],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 15),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFF4A4A49),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                categories[index]["icon"]!,
                                width: 26,
                                height: 26,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            categories[index]["label"]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
