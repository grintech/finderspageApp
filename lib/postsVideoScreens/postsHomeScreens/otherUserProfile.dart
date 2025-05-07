import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:projects/data/models/userModel.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/util.dart';

import '../../controllers/postsHomeController.dart';
import '../../data/apiConstants.dart';
import '../../utils/imageViewer.dart';

class OtherUserProfile extends StatelessWidget {
  OtherUserProfile({Key? key, this.userModel});

  final UserModel? userModel;
  final controller =Get.put(PostsHomeController());

  final List<String> serviceTxt = [
    "Posts",
    "Videos",
    "Business",
    "Ads",
    "Shopping",
    "Community",
    "Services",
    "Entertainment Industry",
    "Fundraiser",
  ];

  var selected = 0.obs;

  @override
  Widget build(BuildContext context) {
    controller.getProfileApi(userModel!.user!.id!);
    String? bioHtml = userModel!.user!.bio ?? "No Bio Added Yet!";
    String plainTxt = Utils().removeHtmlTags(bioHtml);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: whiteColor,
      ),
      body: userModel!.user != null
          ?Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                height: 250,
                width: Get.width,
                child: userModel!.user!.cover_img == null?Image.asset(
                  "assets/images/no_image.png",
                  fit: BoxFit.fill,
                ):Image.network("${ApiConstants.profileUrl}/${userModel!.user!.cover_img}",
                fit: BoxFit.contain,
                ),
                // Obx(() {
                //   final user = controller.userModel.value?.user;
                //
                //   if (user == null) {
                //     return const Center(child: CircularProgressIndicator()); // Optional: while data loads
                //   }
                //
                //   final coverImg = user.cover_img;
                //
                //   // Check if coverImg is null, empty, or literally "null" (string)
                //   final isValidImage = coverImg != null &&
                //       coverImg.trim().isNotEmpty &&
                //       coverImg.trim().toLowerCase() != 'null';
                //
                //   if (!isValidImage) {
                //     return Image.asset(
                //       "assets/images/no_image.png",
                //       fit: BoxFit.contain,
                //     );
                //   }
                //
                //   final url = Uri.tryParse("${ApiConstants.profileUrl}/$coverImg");
                //
                //   if (url == null || !url.hasAbsolutePath || !url.isAbsolute) {
                //     return Image.asset(
                //       "assets/images/no_image.png",
                //       fit: BoxFit.contain,
                //     );
                //   }
                //
                //   return Image.network(
                //     url.toString(),
                //     fit: BoxFit.cover,
                //     loadingBuilder: (context, child, loadingProgress) {
                //       if (loadingProgress == null) return child;
                //       return const Center(child: CircularProgressIndicator());
                //     },
                //     errorBuilder: (context, error, stackTrace) {
                //       return Image.asset(
                //         "assets/images/no_image.png",
                //         fit: BoxFit.contain,
                //       );
                //     },
                //   );
                // }),
              ),
              Positioned(
                top: 0, right: 0, left: 0,
                child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 20,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios, color: fieldBorderColor,),
                      Row(
                        children: [
                          GestureDetector(
                              onTap:(){
                                final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromRect(
                                    // Position popup near the item
                                    Offset(350, 60) & const Size(40, 40),
                                    Offset.zero & overlay.size,
                                  ),
                                  color: whiteColor,
                                  items: [
                                    PopupMenuItem<int>(
                                      height: 30,
                                      value: 0,
                                      child: MyTextWidget(data: "Block Notification", size: 10),
                                      onTap: () {
                                      },
                                    ),
                                    PopupMenuItem<int>(
                                      height: 30,
                                      value: 1,
                                      child: MyTextWidget(data: "Hide Notification", size: 10),
                                      onTap: () {
                                      },
                                    ),
                                  ],
                                );
                              },
                              child: Icon(Icons.notifications_none_outlined, color: fieldBorderColor,)),
                          SizedBox(width: 8,),
                          GestureDetector(
                              onTap: () {
                                final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromRect(
                                    // Position popup near the item
                                    Offset(350, 60) & const Size(40, 40),
                                    Offset.zero & overlay.size,
                                  ),
                                  color: whiteColor,
                                  items: [
                                    PopupMenuItem<int>(
                                      height: 30,
                                      value: 0,
                                      child: MyTextWidget(data: "Block User", size: 10),
                                      onTap: () {
                                      },
                                    ),
                                    PopupMenuItem<int>(
                                      height: 30,
                                      value: 1,
                                      child: MyTextWidget(data: "Report User", size: 10),
                                      onTap: () {
                                      },
                                    ),
                                  ],
                                );
                              },
                              child: Icon(Icons.more_vert, color: fieldBorderColor,))
                        ],
                      )
                    ],
                  ),
                ),
              ),),
              Positioned(
                left: 20,
                child: Container(
                  height: 70, width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: userModel!.user!.image == null?ImageView(height: 80, width: 70,):
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.network("${ApiConstants.profileUrl}/${userModel!.user!.image}",
                      fit: BoxFit.contain,
                    ),
                  ),
                  // controller.userModel.value?.user?.image == "" || controller.userModel.value?.user?.image == null ?
                  // ImageView(height: 80, width: 70,) : ClipRRect(borderRadius: BorderRadius.circular(50),
                  //     child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.user?.image}",
                  //       width: 80, height: 80,fit: BoxFit.fill,)),
                ),
              )
            ],
          ),
          // Obx(()=> Stack(
          //   alignment: Alignment.bottomCenter,
          //   children: [
          //     Stack(
          //       children: [
          //         Container(
          //           margin: const EdgeInsets.only(bottom: 40),
          //           height: 180,
          //           width: Get.width,
          //           child: Image.asset(
          //             "assets/images/no_image.png",
          //             fit: BoxFit.contain,
          //           ),
          //           // Obx(() {
          //           //   final user = controller.userModel.value?.user;
          //           //
          //           //   if (user == null) {
          //           //     return const Center(child: CircularProgressIndicator()); // Optional: while data loads
          //           //   }
          //           //
          //           //   final coverImg = user.cover_img;
          //           //
          //           //   // Check if coverImg is null, empty, or literally "null" (string)
          //           //   final isValidImage = coverImg != null &&
          //           //       coverImg.trim().isNotEmpty &&
          //           //       coverImg.trim().toLowerCase() != 'null';
          //           //
          //           //   if (!isValidImage) {
          //           //     return Image.asset(
          //           //       "assets/images/no_image.png",
          //           //       fit: BoxFit.contain,
          //           //     );
          //           //   }
          //           //
          //           //   final url = Uri.tryParse("${ApiConstants.profileUrl}/$coverImg");
          //           //
          //           //   if (url == null || !url.hasAbsolutePath || !url.isAbsolute) {
          //           //     return Image.asset(
          //           //       "assets/images/no_image.png",
          //           //       fit: BoxFit.contain,
          //           //     );
          //           //   }
          //           //
          //           //   return Image.network(
          //           //     url.toString(),
          //           //     fit: BoxFit.cover,
          //           //     loadingBuilder: (context, child, loadingProgress) {
          //           //       if (loadingProgress == null) return child;
          //           //       return const Center(child: CircularProgressIndicator());
          //           //     },
          //           //     errorBuilder: (context, error, stackTrace) {
          //           //       return Image.asset(
          //           //         "assets/images/no_image.png",
          //           //         fit: BoxFit.contain,
          //           //       );
          //           //     },
          //           //   );
          //           // }),
          //         ),
          //       ],
          //     ),
          //     Positioned(
          //       left: 20,
          //       child: GestureDetector(
          //         onTap: () {
          //           // selectProfileImage();
          //           // Get.toNamed(Routes.editProfileRoute);
          //         },
          //         child: Stack(
          //           children: [
          //             Container(
          //               height: 70, width: 70,
          //               decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //               ),
          //               child: ImageView(height: 80, width: 70,),
          //               // controller.userModel.value?.user?.image == "" || controller.userModel.value?.user?.image == null ?
          //               // ImageView(height: 80, width: 70,) : ClipRRect(borderRadius: BorderRadius.circular(50),
          //               //     child: Image.network("${ApiConstants.profileUrl}/${controller.userModel.value?.user?.image}",
          //               //       width: 80, height: 80,fit: BoxFit.fill,)),
          //             ),
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          // ),),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextWidget(data: "@${userModel?.user?.username}", size: 16, color: blackColor, weight: FontWeight.w600,),
                    // SizedBox(height: 6,),
                    userModel?.user?.profession == null?SizedBox():
                    MyTextWidget(data: "${userModel?.user?.profession}", size: 14, color: blackColor, weight: FontWeight.w500,),
                    SizedBox(height: 6,),
                    CommonButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      radius: 6,
                      onPressed: (){},
                      btnTxt: "Follow",
                    ),
                    SizedBox(height: 12,),
                    CommonButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      radius: 6,
                      onPressed: (){},
                      btnTxt: "Message",
                    ),
                  ],
                ),
                SizedBox(width: 10,),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextWidget(data: "${userModel?.user?.first_name}", size: 14, color: blackColor, weight: FontWeight.w600,),
                      // SizedBox(height: 6,),
                      userModel?.user?.phonenumber == null?SizedBox():
                      MyTextWidget(data: "${userModel?.user?.phonenumber}", size: 14, color: blackColor, weight: FontWeight.w600,),
                      // SizedBox(height: 6,),
                      plainTxt == ""?SizedBox():
                      MyTextWidget(data: plainTxt, size: 12, color: blackColor,
                        weight: FontWeight.w500,),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                userModel!.user!.facebook==null?SizedBox():
                Image.asset("assets/images/ic_facebook.png", height: 30, width: 30,),
                SizedBox(width: 12,),
                userModel!.user!.instagram==null?SizedBox():
                Image.asset("assets/images/ic_insta.png", height: 30, width: 30,),
                SizedBox(width: 12,),
                userModel!.user!.twitter==null?SizedBox():
                Image.asset("assets/images/ic_twitter.png", height: 30, width: 30,),
                SizedBox(width: 12,),
                userModel!.user!.linkedin==null?SizedBox():
                Image.asset("assets/images/ic_linkedin.png", height: 30, width: 30,),
                SizedBox(width: 12,),
                userModel!.user!.whatsapp==null?SizedBox():
                Image.asset("assets/images/ic_whatsapp.png", height: 30, width: 30,),
                SizedBox(width: 12,),
                userModel!.user!.Tiktok==null?SizedBox():
                Image.asset("assets/images/ic_tiktok.png", height: 35, width: 35,),
                SizedBox(width: 12,),
                userModel!.user!.youtube==null?SizedBox():
                Image.asset("assets/images/ic_youtube.png", height: 30, width: 30,),
              ],
            ),
          ),
          Container(
            height: 30,
            width: Get.width,
            alignment: Alignment.center,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 10),
                itemCount: serviceTxt.length,
                itemBuilder: (context, index){
              return Obx(()=> GestureDetector(
                onTap: () {
                  selected.value = index;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyTextWidget(data: serviceTxt[index],
                    color: selected.value == index?fieldBorderColor:blackColor,),
                ),
              ),);
            })
          ),
          Obx(()=>Expanded(child: _buildListForSelectedTab(selected.value)))
        ],
      )
          :Center(child: Text('No user data provided.')),
    );
  }
  Widget _buildListForSelectedTab(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return userModel!.post!.isNotEmpty?ListView.builder(
          itemCount: userModel!.post!.length,
          itemBuilder: (context, index) {
            return MyTextWidget(data: "${userModel!.post![index].image_data}");
          },
        ):Center(child: MyTextWidget(data: "No Posts Found"));
      case 1:
        return ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return MyTextWidget(data: "List for Tab 1 - Item $index");
          },
        );
      case 2:
        return userModel!.business!.isNotEmpty?ListView.builder(
          itemCount: userModel!.business!.length,
          itemBuilder: (context, index) {
            return MyTextWidget(data: "List for Tab 2 - Item $index");
          },
        ):Center(child: MyTextWidget(data: "No Business Found"));
      case 3:
        return userModel!.ads!.isNotEmpty?ListView.builder(
          itemCount: userModel!.ads!.length,
          itemBuilder: (context, index) {
            return MyTextWidget(data: "${userModel!.ads![index].title}");
          },
        ):Center(child: MyTextWidget(data: "No Ads Found"));
      case 4:
        return userModel!.shopping!.isNotEmpty
            ?ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return MyTextWidget(data: "List for Tab 4 - Item $index");
          },
        ):Center(child: MyTextWidget(data: "No Shopping Data Found"));
      case 5:
        return userModel!.community!.isNotEmpty?ListView.builder(
          itemCount: userModel!.community!.length,
          itemBuilder: (context, index) {
            return MyTextWidget(data: "List for Tab 5 - Item $index");
          },
        ):Center(child: MyTextWidget(data: "No Community Found"));
      case 6:
        return userModel!.service!.isNotEmpty?ListView.builder(
          itemCount: userModel!.service!.length,
          itemBuilder: (context, index) {
            return MyTextWidget(data: "List for Tab 6 - Item $index");
          },
        ):Center(child: MyTextWidget(data: "No Services Found"));
      case 7:
        return userModel!.entertainment!.isNotEmpty?ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return MyTextWidget(data: "List for Tab 7 - Item $index");
          },
        ):Center(child: MyTextWidget(data: "No Data Found"));
      case 8:
        return userModel!.fundraisers!.isNotEmpty?ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return MyTextWidget(data: "List for Tab 8 - Item $index");
          },
        ):Center(child: MyTextWidget(data: "No Fundraisers Found"));
      case 9:
        return Center(child: MyTextWidget(data: "Tab 9 Content"));
      default:
        return Center(child: MyTextWidget(data: "No content available"));
    }
  }

}
