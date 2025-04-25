import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/controllers/postProfileController.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/data/apiConstants.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/util.dart';
import '../../utils/colorConstants.dart';
import '../../utils/routes.dart';

class PostProfileScreen extends StatelessWidget {
  PostProfileScreen({super.key});

  final selectedIndex = 0.obs;
  var coverImagePath = ''.obs;
  var profileImagePath = ''.obs;

  final controller = Get.lazyPut(() => PostProfileController());


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostProfileController>(builder: (controller){
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
                        PopupMenuItem(value: 10,
                          onTap: () {
                            Get.toNamed(Routes.postsSetting);
                          },
                          child: Row(children: [
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
             Obx(()=> Stack(
               alignment: Alignment.bottomCenter,
               children: [
                 Stack(
                   children: [
                     Container(
                       margin: const EdgeInsets.only(bottom: 40),
                       height: 180,
                       width: Get.width,
                       child: Obx(() {
                         final user = controller.userModel.value?.user;

                         if (user == null) {
                           return const Center(child: CircularProgressIndicator()); // Optional: while data loads
                         }

                         final coverImg = user.cover_img;

                         // Check if coverImg is null, empty, or literally "null" (string)
                         final isValidImage = coverImg != null &&
                             coverImg.trim().isNotEmpty &&
                             coverImg.trim().toLowerCase() != 'null';

                         if (!isValidImage) {
                           return Image.asset(
                             "assets/images/no_image.png",
                             fit: BoxFit.contain,
                           );
                         }

                         final url = Uri.tryParse("${ApiConstants.profileUrl}/$coverImg");

                         if (url == null || !url.hasAbsolutePath || !url.isAbsolute) {
                           return Image.asset(
                             "assets/images/no_image.png",
                             fit: BoxFit.contain,
                           );
                         }

                         return Image.network(
                           url.toString(),
                           fit: BoxFit.cover,
                           loadingBuilder: (context, child, loadingProgress) {
                             if (loadingProgress == null) return child;
                             return const Center(child: CircularProgressIndicator());
                           },
                           errorBuilder: (context, error, stackTrace) {
                             return Image.asset(
                               "assets/images/no_image.png",
                               fit: BoxFit.contain,
                             );
                           },
                         );
                       }),
                     ),
                   ],
                 ),
                 Positioned(
                   left: 20,
                   child: GestureDetector(
                     onTap: () {
                       // selectProfileImage();
                       // Get.toNamed(Routes.editProfileRoute);
                     },
                     child: Stack(
                       children: [
                         Container(
                           height: 70, width: 70,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                           ),
                           child: controller.userModel.value?.user?.image == "" || controller.userModel.value?.user?.image == null ?
                           ImageView(height: 80, width: 70,) : ClipRRect(borderRadius: BorderRadius.circular(50),
                               child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.user?.image}",
                                 width: 80, height: 80,fit: BoxFit.fill,)),
                         ),
                       ],
                     ),
                   ),
                 )
               ],
             ),),
              Obx(()=>Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: MyTextWidget(data: "@${controller.userModel.value?.user?.username}",size: 14, weight: FontWeight.w600,),
                  )),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonButton(
                      onPressed: () => Get.toNamed(Routes.editProfileRoute),
                      radius: 10,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      btnTxt: "Edit Profile",
                    ),
                    SizedBox(width: 30,),
                    CommonButton(
                      radius: 10,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      btnTxt: "Share Profile",
                    )
                  ],
                ),
              ),
              Obx(()=>controller.userModel.value?.followerDetails?.length != 0?
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(text: TextSpan(
                        children: [
                          TextSpan(
                              text:controller.userModel.value?.followerDetails?.length.toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: blackColor)
                          ),
                          TextSpan(
                              text: " My Connections",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: blackColor)
                          ),
                        ]
                    ))
                  ],
                ),
              ):SizedBox(),),

              Obx(()=>controller.userModel.value?.followerDetails?.length != 0?
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.userModel.value?.followerDetails?.length,
                    itemBuilder: (context, index){
                      return Container(
                        height: 40, width: 40,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: controller.userModel.value?.followerDetails?[index].image == "" || controller.userModel.value?.followerDetails?[index].image == null ?
                        ImageView(height: 40, width: 40,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                            child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.followerDetails?[index].image}",
                              width: 40, height: 40, fit: BoxFit.fill,)),
                      );
                    }),
              ):SizedBox(child: MyTextWidget(data: "No Connections Yet",),),),

              Obx(()=>Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap:() {
                          selectedIndex.value = 0;
                        },
                        child: MyTextWidget(data: "Posts", size: 12,
                            weight: selectedIndex.value == 0 ? FontWeight.w500 : FontWeight.w400)
                    ),
                    GestureDetector(
                      onTap: () {
                        selectedIndex.value = 1;
                      },
                      child: MyTextWidget(data: "Videos",size: 12,
                        weight: selectedIndex.value == 1 ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          selectedIndex.value = 2;
                        },
                        child: MyTextWidget(data: "Business",size: 12,
                          weight: selectedIndex.value == 2? FontWeight.w500 : FontWeight.w400,)),
                    Row(
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
                                    height: 300,
                                    child: ListView(
                                      children: [
                                        ListTile(title: Text("Shopping"),
                                          onTap: (){
                                          selectedIndex.value = 4;
                                          Get.back();
                                          },),
                                        ListTile(title: Text("Community"),
                                          onTap: (){
                                          selectedIndex.value = 5;
                                          Get.back();
                                          },),
                                        ListTile(title: Text("Services"),
                                          onTap: (){
                                          selectedIndex.value = 6;
                                          Get.back();
                                          },),
                                        ListTile(title: Text("Entertainment Industry"),
                                          onTap: (){
                                          selectedIndex.value = 7;
                                          Get.back();
                                          },),
                                        ListTile(title: Text("Fundraiser"),
                                          onTap: (){
                                            selectedIndex.value = 8;
                                            Get.back();
                                          },),
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
                    ),
                  ],
                ),
              ),),
              controller.userModel.value?.post?.length==0 ||
                  controller.userModel.value?.entertainment?.length==0 ||
                  controller.userModel.value?.business?.length==0 ||
                  controller.userModel.value?.ads?.length==0 ||
                  controller.userModel.value?.fundraisers?.length==0 ||
                  controller.userModel.value?.shopping?.length==0 ||
                  controller.userModel.value?.community?.length==0 ||
                  controller.userModel.value?.service?.length==0?
              Obx(()=>selectedIndex.value == 0? ListView.builder(
                  itemCount: controller.userModel.value?.post?.length,
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
                                      height: 40, width: 40,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: controller.userModel.value?.user?.image == "" || controller.userModel.value?.user?.image == null ?
                                      ImageView(height: 40, width: 40,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                          child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.user?.image}",
                                            width: 40, height: 40, fit: BoxFit.fill,)),
                                    ),
                                    MyTextWidget(data: "${controller.userModel.value?.user?.username}", size: 12, weight: FontWeight.w500,)
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
                            height:240, width:Get.width,
                              decoration:BoxDecoration(
                                  color: Colors.grey.shade200
                              ),
                              child: controller.userModel.value?.post?[index].image == ""
                                  || controller.userModel.value?.post?[index].image == null ?
                              Image.asset("assets/images/no_image.png", fit: BoxFit.fill,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                  child: Image.network("${ApiConstants.postImgUrl}/${controller.userModel.value?.post?[index].image}",
                                    width: 40, height: 40, fit: BoxFit.contain,)),)
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
                                    MyTextWidget(data: "${controller.userModel.value?.user?.username}", size: 12, weight: FontWeight.w500,)
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
                            height:240, width:Get.width,
                              decoration:BoxDecoration(
                                  color: Colors.grey.shade200
                              ),
                              child: Image.asset("assets/images/no_image.png",
                                fit: BoxFit.fill,))
                        ],
                      ),
                    );
                  }) :
              selectedIndex.value == 2? ListView.builder(
                  itemCount: controller.userModel.value?.business?.length,
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
                                      height: 40, width: 40,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: controller.userModel.value?.user?.image == "" || controller.userModel.value?.user?.image == null ?
                                      ImageView(height: 40, width: 40,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                          child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.user?.image}",
                                            width: 40, height: 40, fit: BoxFit.fill,)),
                                    ),
                                    MyTextWidget(data: "${controller.userModel.value?.user?.username}", size: 12, weight: FontWeight.w500,)
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
                            height:240, width:Get.width,
                            decoration:BoxDecoration(
                                color: Colors.grey.shade200
                            ),
                            child: controller.userModel.value?.business?[index].image == ""
                                || controller.userModel.value?.business?[index].image == null ?
                            Image.asset("assets/images/no_image.png", fit: BoxFit.fill,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                child: Image.network("${ApiConstants.businessImgUrl}/${controller.userModel.value?.business?[index].image}",
                                  width: 40, height: 40, fit: BoxFit.contain,)),)
                        ],
                      ),
                    );
                  }) :
              selectedIndex.value == 3? ListView.builder(
                  itemCount: controller.userModel.value?.ads?.length,
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
                                      height: 40, width: 40,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: controller.userModel.value?.user?.image == "" || controller.userModel.value?.user?.image == null ?
                                      ImageView(height: 40, width: 40,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                          child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.user?.image}",
                                            width: 40, height: 40, fit: BoxFit.fill,)),
                                    ),
                                    MyTextWidget(data: "${controller.userModel.value?.user?.username}", size: 12, weight: FontWeight.w500,)
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
                            height:240, width:Get.width,
                            decoration:BoxDecoration(
                                color: Colors.grey.shade200
                            ),
                            child: controller.userModel.value?.ads?[index].image == ""
                                || controller.userModel.value?.ads?[index].image == null ?
                            Image.asset("assets/images/no_image.png", fit: BoxFit.fill,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                child: Image.network("${ApiConstants.postImgUrl}/${controller.userModel.value?.ads?[index].image}",
                                  width: 40, height: 40, fit: BoxFit.contain,)),)
                        ],
                      ),
                    );
                  }) :
              selectedIndex.value == 4? ListView.builder(
                  itemCount: controller.userModel.value?.shopping?.length,
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
                                      height: 40, width: 40,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: controller.userModel.value?.user?.image == "" || controller.userModel.value?.user?.image == null ?
                                      ImageView(height: 40, width: 40,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                          child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.user?.image}",
                                            width: 40, height: 40, fit: BoxFit.fill,)),
                                    ),
                                    MyTextWidget(data: "${controller.userModel.value?.user?.username}", size: 12, weight: FontWeight.w500,)
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
                            height:240, width:Get.width,
                            decoration:BoxDecoration(
                                color: Colors.grey.shade200
                            ),
                            child: controller.userModel.value?.shopping?[index].image == ""
                                || controller.userModel.value?.shopping?[index].image == null ?
                            Image.asset("assets/images/no_image.png", fit: BoxFit.fill,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                child: Image.network("${ApiConstants.postImgUrl}/${controller.userModel.value?.shopping?[index].image}",
                                  width: 40, height: 40, fit: BoxFit.contain,)),)
                        ],
                      ),
                    );
                  }) :
              selectedIndex.value == 5? ListView.builder(
                  itemCount: controller.userModel.value?.community?.length,
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
                                      height: 40, width: 40,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: controller.userModel.value?.user?.image == "" || controller.userModel.value?.user?.image == null ?
                                      ImageView(height: 40, width: 40,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                          child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.user?.image}",
                                            width: 40, height: 40, fit: BoxFit.fill,)),
                                    ),
                                    MyTextWidget(data: "${controller.userModel.value?.user?.username}", size: 12, weight: FontWeight.w500,)
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
                            height:240, width:Get.width,
                            decoration:BoxDecoration(
                                color: Colors.grey.shade200
                            ),
                            child: controller.userModel.value?.community?[index].image == ""
                                || controller.userModel.value?.community?[index].image == null ?
                            Image.asset("assets/images/no_image.png", fit: BoxFit.fill,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                child: Image.network("${ApiConstants.postImgUrl}/${controller.userModel.value?.community?[index].image}",
                                  width: 40, height: 40, fit: BoxFit.contain,)),)
                        ],
                      ),
                    );
                  }) :
              selectedIndex.value == 6? ListView.builder(
                  itemCount: controller.userModel.value?.service?.length,
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
                                      height: 40, width: 40,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: controller.userModel.value?.user?.image == "" || controller.userModel.value?.user?.image == null ?
                                      ImageView(height: 40, width: 40,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                          child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.user?.image}",
                                            width: 40, height: 40, fit: BoxFit.fill,)),
                                    ),
                                    MyTextWidget(data: "${controller.userModel.value?.user?.username}", size: 12, weight: FontWeight.w500,)
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
                            height:240, width:Get.width,
                            decoration:BoxDecoration(
                                color: Colors.grey.shade200
                            ),
                            child: controller.userModel.value?.service?[index].image == ""
                                || controller.userModel.value?.service?[index].image == null ?
                            Image.asset("assets/images/no_image.png", fit: BoxFit.fill,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                child: Image.network("${ApiConstants.postImgUrl}/${controller.userModel.value?.service?[index].image}",
                                  width: 40, height: 40, fit: BoxFit.contain,)),)
                        ],
                      ),
                    );
                  }) :
              selectedIndex.value == 7? ListView.builder(
                  itemCount: controller.userModel.value?.entertainment?.length,
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
                                      height: 40, width: 40,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: controller.userModel.value?.user?.image == "" || controller.userModel.value?.user?.image == null ?
                                      ImageView(height: 40, width: 40,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                          child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.user?.image}",
                                            width: 40, height: 40, fit: BoxFit.fill,)),
                                    ),
                                    MyTextWidget(data: "${controller.userModel.value?.user?.username}", size: 12, weight: FontWeight.w500,)
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
                            height:240, width:Get.width,
                            decoration:BoxDecoration(
                                color: Colors.grey.shade200
                            ),
                            child: controller.userModel.value?.entertainment?[index].image == ""
                                || controller.userModel.value?.entertainment?[index].image == null ?
                            Image.asset("assets/images/no_image.png", fit: BoxFit.fill,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                child: Image.network("${ApiConstants.entertainImgUrl}/${controller.userModel.value?.entertainment?[index].image}",
                                  width: 40, height: 40, fit: BoxFit.contain,)),)
                        ],
                      ),
                    );
                  }) :
              ListView.builder(
                  itemCount: controller.userModel.value?.fundraisers?.length,
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
                                      height: 40, width: 40,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: controller.userModel.value?.user?.image == "" || controller.userModel.value?.user?.image == null ?
                                      ImageView(height: 40, width: 40,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                          child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.user?.image}",
                                            width: 40, height: 40, fit: BoxFit.fill,)),
                                    ),
                                    MyTextWidget(data: "${controller.userModel.value?.user?.username}", size: 12, weight: FontWeight.w500,)
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
                            height:240, width:Get.width,
                            decoration:BoxDecoration(
                                color: Colors.grey.shade200
                            ),
                            child: controller.userModel.value?.fundraisers?[index].image == ""
                                || controller.userModel.value?.fundraisers?[index].image == null ?
                            Image.asset("assets/images/no_image.png", fit: BoxFit.fill,) : ClipRRect(borderRadius: BorderRadius.circular(30),
                                child: Image.network("${ApiConstants.postImgUrl}/${controller.userModel.value?.fundraisers?[index].image}",
                                  width: 40, height: 40, fit: BoxFit.contain,)),)
                        ],
                      ),
                    );
                  })
              ):
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: MyTextWidget(data: "No content is published yet",),
              ),
            ],
          ),
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
