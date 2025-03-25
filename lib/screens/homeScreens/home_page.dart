import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/homeController.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/routes.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key) {
    // controller.getHomeCategories();
  }

  final List<String> iconList = [
    "assets/images/icon6.png", "assets/images/ic_business.png", "assets/images/icon7.png",
    "assets/images/ic_fundraiser.png", "assets/images/icon1.png","assets/images/icon6.png", "assets/images/icon2.png",
    "assets/images/icon5.png", "assets/images/icon4.png","assets/images/icon3.png"
  ];

  final controller = Get.put(HomeController());

  final showSearch = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: Drawer(
      //   backgroundColor: Colors.white,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           gradient: LinearGradient(
      //             colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
      //             begin: Alignment.topCenter,
      //             end: Alignment.bottomCenter,
      //             stops: [0.3, 1.0],
      //           ),
      //
      //         ),
      //         child: Align(
      //           alignment: Alignment.topLeft,
      //           child: Text(
      //             'Finderspage',
      //             style: TextStyle(
      //               fontSize: 20,
      //               fontWeight: FontWeight.bold,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.home, color: Colors.black),
      //         title: Text('Home', style: TextStyle(color: Colors.black)),
      //         onTap: () {
      //           Get.back();
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.settings, color: Colors.black),
      //         title: Text('Settings', style: TextStyle(color: Colors.black)),
      //         onTap: () {
      //           Get.back();
      //         },
      //       ),
      //       ListTile(
      //         leading: Image.asset("assets/images/logout-icon.png"),
      //         title: Text('Logout', style: TextStyle(color: Colors.black)),
      //         onTap: () {
      //           Get.offAllNamed(Routes.loginRoute);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, 
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/new_logo.png",
                height: 41.21,
                width: 40,
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 12,),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/images/ic_location_white.png", height: 16, width: 13,),
                        SizedBox(width: 8),
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
                  GestureDetector(
                    onTap: () {
                      showSearch.value = !showSearch.value;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Icon(Icons.search, color: fieldBorderColor, size: 26,),
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.notifications_none,
                  //     size: 28,
                  //     color: Colors.black,
                  //   ),
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, Routes.notificationRoute);
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusScopeNode());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Obx(()=> Visibility(
               visible: !showSearch.value,
               child: Container(
                 height: 40,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(5),
                   border: Border.all(
                     color: searchBorderColor,
                     width: 1,
                   ),
                 ),
                 child: Expanded(
                   child: TextField(
                     decoration: InputDecoration(
                       hintText: "Search",
                       filled: true,
                       fillColor: Colors.white,
                       contentPadding: EdgeInsets.symmetric(
                         vertical: 10,
                         horizontal: 10,
                       ),
                       border: InputBorder.none,
                     ),
                     style: TextStyle(fontSize: 16),
                   ),
                 ),
               ),
             ),),
             Obx(()=> Expanded(
               child: GridView.builder(
                 padding: EdgeInsets.symmetric(vertical: 12),
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   crossAxisSpacing: 12,
                   mainAxisSpacing: 12,
                   childAspectRatio: 1.2,
                 ),
                 itemCount: controller.categoryList.length,
                 itemBuilder: (context, index) {
                   return GestureDetector(
                     onTap: () {
                       controller.categoryList[index].id;
                       print("${controller.categoryList[index].id}");
                       switch (index) {
                         case 0:
                           Get.toNamed(Routes.defaultScreen);
                           break;
                         case 1:
                           Get.toNamed(Routes.defaultScreen);
                           break;
                         case 2:
                           Get.toNamed(Routes.defaultScreen);
                           break;
                         case 3:
                           Get.toNamed(Routes.defaultScreen);
                           break;
                         case 4:
                           Get.toNamed(Routes.jobList);
                           break;
                         case 5:
                           Get.toNamed(Routes.postsHome);
                           break;
                         case 6:
                           Get.toNamed(Routes.estateList);
                           break;
                         case 7:
                           Get.toNamed(Routes.defaultScreen);
                           break;
                         case 8:
                           Get.toNamed(Routes.shop);
                           break;
                         case 9:
                           Get.toNamed(Routes.communityList);
                           break;
                         default:
                           Get.toNamed(Routes.defaultScreen);
                           break;
                       }
                     },
                     child: Container(
                       decoration: BoxDecoration(
                         gradient: LinearGradient(
                           colors: [Color(0xFFDC7228), Color(0xFF000000)],
                           begin: Alignment.topCenter,
                           end: Alignment.bottomCenter,
                           stops: [0.5, 0.6],
                         ),
                         borderRadius: BorderRadius.circular(5),
                       ),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                             width: 40,
                             height: 40,
                             margin: EdgeInsets.only(top: 10),
                             decoration: BoxDecoration(
                               color: Color(0xFF4A4A49),
                               shape: BoxShape.circle,
                             ),
                             child: Center(
                               child:Image.asset(
                                 height: 26, width: 26,
                                   iconList[index % iconList.length]
                               )
                             ),
                           ),
                           SizedBox(height: 10),
                           Text(
                             controller.categoryList[index].title!,
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
             ),)
            ],
          ),
        ),
      ),
    );
  }
}
