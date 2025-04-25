import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postProfileController.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/CommonAppBar.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:projects/utils/util.dart';

import '../../../utils/routes.dart';

class PostsSettingScreen extends StatelessWidget {
  PostsSettingScreen({super.key});

  final controller = Get.put(PostProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        leading: true,
        title: "Account Settings",
        centreTxt: true,
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: (){
              Get.dialog(
                Center(
                  child: Container(
                    height: 280,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: MyTextWidget(data: "Change Password", size: 18, color: blackColor, weight: FontWeight.w500,),
                        ),
                        CommonTextField(
                          margin: EdgeInsets.only(bottom: 20),
                          hint: "Enter New Password",
                          length: 6,
                        ),
                        CommonTextField(
                          margin: EdgeInsets.only(bottom: 30),
                          hint: "Confirm Password",
                          length: 6,
                        ),
                        CommonButton(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          radius: 12,
                          btnTxt: "Update",
                        )
                      ],
                    ),
                  ),
                )
              );
            },
            title: MyTextWidget(data: "Change Password",),
          ),
          ListTile(
            title: MyTextWidget(data: "Notification",),
          ),
          ListTile(
            onTap: (){
              // controller.logOut();
              // Utils.showLoader();
              StorageHelper().clearAll();
              // Utils.hideLoader();
              Get.offAllNamed(Routes.loginRoute);
            },
            title: MyTextWidget(data: "Log Out",),
          ),
        ],
      ),
    );
  }
}
