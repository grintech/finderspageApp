import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/utils/util.dart';
import '../../utils/colorConstants.dart';
import '../../utils/routes.dart';

class PostProfileScreen extends StatelessWidget {
  PostProfileScreen({super.key});

  final selectedIndex = 0.obs;
  var coverImagePath = ''.obs;
  var profileImagePath = ''.obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        surfaceTintColor: blackColor,
        leading: GestureDetector(
          // onTap: () => Get.offAllNamed(Routes.homeRoute),
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
           child: PopupMenuButton<int>(
             color: whiteColor,
               surfaceTintColor: whiteColor,
               icon: Icon(Icons.menu, color: whiteColor,),
               offset: Offset(-12, 35),
               menuPadding: EdgeInsets.zero,
               itemBuilder: (context){
             return <PopupMenuEntry<int>>[
               PopupMenuItem(value: 0,child: Row(
                 children: [
                   Image.asset("assets/images/ic_edit.png", scale: 22,),
                   SizedBox(width: 10,),
                   Text("Create Ads"),
                 ],
               ),),
               PopupMenuItem(value: 1,child: Row(
                 children: [
                   Image.asset("assets/images/ic_fund.png", scale: 22,),
                   SizedBox(width: 10,),
                   Text("Create Fundraisers"),
                 ],
               ),),
               PopupMenuItem(value: 2,child: Row(
                 children: [
                   Image.asset("assets/images/ic_bus_page.png", scale: 22,),
                   SizedBox(width: 10,),
                   Text("Create Business Page"),
                 ],
               ),),
               PopupMenuItem(value: 3,child: Row(
                 children: [
                   Image.asset("assets/images/ic_resume.png", scale: 22,),
                   SizedBox(width: 10,),
                   Text("Create Resume"),
                 ],
               ),),
               PopupMenuItem(value: 4,child: Row(
                 children: [
                   Image.asset("assets/images/ic_save.png", scale: 22,),
                   SizedBox(width: 10,),
                   Text("Saved"),
                 ],
               ),),
               PopupMenuItem(value: 5,child: Row(
                 children: [
                   Image.asset("assets/images/ic_support.png", scale: 22,),
                   SizedBox(width: 10,),
                   Text("Support"),
                 ],
               ),),
               PopupMenuItem(value: 6,child: Row(
                 children: [
                   Image.asset("assets/images/ic_subscription.png", scale: 22,),
                   SizedBox(width: 10,),
                   Text("Subscriptions"),
                 ],
               ),),
               PopupMenuItem(value: 7,child: Row(
                 children: [
                   Icon(Icons.delete, size: 30, color: blackColor,),
                   SizedBox(width: 10,),
                   Text("Recently Deleted"),
                 ],
               ),),
               PopupMenuItem(value: 8,child: Row(
                 children: [
                   Image.asset("assets/images/ic_blocked.png", scale: 22,),
                   SizedBox(width: 10,),
                   Text("Blocked User"),
                 ],
               ),),
               PopupMenuItem(value: 9,
                 onTap: () {
                   selectAccount();
                 },
                 child: Row(
                   children: [
                     Icon(CupertinoIcons.person, color: Colors.black, size: 25,),
                     SizedBox(width: 10,),
                     Text("Switch Accounts"),
                   ],
                 ),),
               PopupMenuItem(value: 10,child: Row(
                 children: [
                   Image.asset("assets/images/ic_settings.png", scale: 22,),
                   SizedBox(width: 10,),
                   Text("Account Settings"),
                 ],
               ),),
             ];
           })
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
                    Obx(()=>Container(
                      margin: EdgeInsets.only(bottom: 40),
                      height: 300,
                      width: Get.width,
                      child: coverImagePath.isEmpty
                          ?Image.asset("assets/images/no_image.png", fit: BoxFit.fill,):
                      Image.file(
                        File(coverImagePath.value),
                        width: Get.width,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),),
                    Positioned(
                      right: 12, bottom: 50,
                      child: GestureDetector(
                        onTap: () {
                          selectCoverImage();
                        },
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
                  child: GestureDetector(
                    onTap: () {
                      selectProfileImage();
                    },
                    child: Stack(
                      children: [
                        Obx(()=>Container(
                          height: 70, width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: profileImagePath.isEmpty
                              ?Image.asset("assets/images/user_img.png",
                            height: 80, width: 70,fit: BoxFit.fill,):
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              File(profileImagePath.value),
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),),
                        Positioned(
                          bottom: 2,
                          right: 0,
                          child: Container(
                            width: 20,
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
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
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

            Container(
              margin: EdgeInsets.only(top: 8),
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: 16,
                  itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  height: 40, width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("assets/images/profile-pic.png")),
                );
              }),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(()=>GestureDetector(
                      onTap:() {
                        selectedIndex.value = 0;
                      },
                      child: MyTextWidget(data: "Posts", size: 12,
                        weight: selectedIndex.value == 0 ? FontWeight.w500 : FontWeight.w400)
                  ),),
                  Obx(()=>GestureDetector(
                    onTap: () {
                      selectedIndex.value = 1;
                    },
                    child: MyTextWidget(data: "Videos",size: 12,
                      weight: selectedIndex.value == 1 ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),),
                  Obx(()=> GestureDetector(
                      onTap: () {
                        selectedIndex.value = 2;
                      },
                      child: MyTextWidget(data: "Business",size: 12,
                        weight: selectedIndex.value == 2? FontWeight.w500 : FontWeight.w400,)),),
                  Obx(()=>Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectedIndex.value = 3;
                        },
                        child: MyTextWidget(data: "Ads",size: 12,
                          weight:selectedIndex.value==3 ? FontWeight.w500 : FontWeight.w400,),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context){
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  height: 250,
                                  child: ListView(
                                    children: [
                                      ListTile(title: Text("Shopping"), onTap: Get.back,),
                                      ListTile(title: Text("Community"),onTap: Get.back,),
                                      ListTile(title: Text("Services"),onTap: Get.back,),
                                      ListTile(title: Text("Entertainment Industry"),onTap: Get.back,),
                                    ],
                                  ),
                                );
                              }
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.keyboard_arrow_down, size: 18,)
                          ],
                        ),
                      )
                    ],
                  ),),

                ],
              ),
            ),
            Obx(()=>selectedIndex.value == 0?
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
                                    height: 30,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset("assets/images/user_img.png", height: 100, fit: BoxFit.fill,),
                                  ),
                                  MyTextWidget(data: "John Doe", size: 12, weight: FontWeight.w500,)
                                ],
                              ),
                              PopupMenuButton<int>(
                                  color: whiteColor,
                                  surfaceTintColor: whiteColor,
                                  icon: Icon(Icons.more_vert, color: blackColor, size: 20,),
                                  offset: Offset(-12, 35),
                                  menuPadding: EdgeInsets.zero,
                                  itemBuilder: (context){
                                    return <PopupMenuEntry<int>>[
                                      PopupMenuItem(value: 0,child: Text("Edit"),),
                                      PopupMenuItem(value: 1,child: Text("Delete"),),
                                    ];
                                  })
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
                }):
            selectedIndex.value == 1? ListView.builder(
                itemCount: 2,
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
                                    height: 30,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset("assets/images/user_img.png", height: 100, fit: BoxFit.fill,),
                                  ),
                                  MyTextWidget(data: "John Doe", size: 12, weight: FontWeight.w500,)
                                ],
                              ),
                              PopupMenuButton<int>(
                                  color: whiteColor,
                                  surfaceTintColor: whiteColor,
                                  icon: Icon(Icons.more_vert, color: blackColor, size: 20,),
                                  offset: Offset(-12, 35),
                                  menuPadding: EdgeInsets.zero,
                                  itemBuilder: (context){
                                    return <PopupMenuEntry<int>>[
                                      PopupMenuItem(value: 0,child: Text("Edit"),),
                                      PopupMenuItem(value: 1,child: Text("Delete"),),
                                    ];
                                  })
                            ],
                          ),
                        ),
                        Container(
                            decoration:BoxDecoration(
                                color: Colors.grey.shade200
                            ),
                            child: Image.asset("assets/images/image1.png", height: 300,
                              width: Get.width, fit: BoxFit.contain,))
                      ],
                    ),
                  );
                }) :
            selectedIndex.value == 2? Padding(
              padding: const EdgeInsets.only(top: 100),
              child: MyTextWidget(data: "Coming Soon", size: 20, weight: FontWeight.w600, color: fieldBorderColor,),
            )
                :ListView.builder(
                    itemCount: 1,
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
                                        height: 30,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset("assets/images/user_img.png", height: 100, fit: BoxFit.fill,),
                                      ),
                                      MyTextWidget(data: "John Doe", size: 12, weight: FontWeight.w500,)
                                    ],
                                  ),
                                  PopupMenuButton<int>(
                                      color: whiteColor,
                                      surfaceTintColor: whiteColor,
                                      icon: Icon(Icons.more_vert, color: blackColor, size: 20,),
                                      offset: Offset(-12, 35),
                                      menuPadding: EdgeInsets.zero,
                                      itemBuilder: (context){
                                        return <PopupMenuEntry<int>>[
                                          PopupMenuItem(value: 0,child: Text("Edit"),),
                                          PopupMenuItem(value: 1,child: Text("Delete"),),
                                        ];
                                      })
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
                    }))
            // MyTextWidget(data: "No content is published yet",),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      coverImagePath.value = image.path;
    }
    // else {
    //   Get.snackbar("Error", "No image selected",
    //       snackPosition: SnackPosition.BOTTOM);
    // }
  }
  Future<void> pickProfileImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      profileImagePath.value = image.path;
    }
    // else {
    //   Get.snackbar("Error", "No image selected",
    //       snackPosition: SnackPosition.BOTTOM);
    // }
  }

  void selectCoverImage(){
    showModalBottomSheet(
        isDismissible: true,
        context: Get.context!,
        builder: (context){
          return Container(
            height: 100,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap:() {
                      pickImage(ImageSource.camera);
                      Get.back();
                    },
                    child: Icon(Icons.camera, color: Colors.white,)),
                GestureDetector(
                    onTap:() {
                      pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    child: Icon(Icons.perm_media_outlined, color: Colors.white,))
              ],
            ),
          );
        });
  }

  void selectProfileImage(){
    showModalBottomSheet(
        isDismissible: true,
        context: Get.context!,
        builder: (context){
          return Container(
            height: 100,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap:() {
                      pickProfileImage(ImageSource.camera);
                      Get.back();
                    },
                    child: Icon(Icons.camera, color: Colors.white,)),
                GestureDetector(
                    onTap:() {
                      pickProfileImage(ImageSource.gallery);
                      Get.back();
                    },
                    child: Icon(Icons.perm_media_outlined, color: Colors.white,))
              ],
            ),
          );
        });
  }

  void selectAccount(){
    showModalBottomSheet(
        context: Get.context!,
        builder: (BuildContext context){
          return SizedBox(
            height: 140,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: MyTextWidget(data: "Add Account",
                    size: 15, color: blackColor, weight: FontWeight.w600,),
                ),
                Divider(thickness: 0.5, height: 1, color: CupertinoColors.systemGrey2,),
                GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.loginRoute, arguments: "profile");
                    },
                    child: MyTextWidget(data: "Login to Existing Account",size: 14, weight: FontWeight.w500, color: fieldBorderColor,)),
                SizedBox(height: 10,),
                GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.signupRoute, arguments: "profile");
                    },
                    child: MyTextWidget(data: "Create New Account",size: 14, weight: FontWeight.w500, color: fieldBorderColor,))
              ],
            ),
          );
        });
  }
}
