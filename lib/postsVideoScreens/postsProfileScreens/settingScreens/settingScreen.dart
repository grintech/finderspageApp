import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postProfileController.dart';
import 'package:projects/utils/commonWidgets/CommonAppBar.dart';
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
