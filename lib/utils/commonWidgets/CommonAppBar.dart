import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/util.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor = Colors.red;
  final String? title;
  final AppBar? appBar;
  final bool? centreTxt;
  final bool? leading;
  final List<Widget>? widgets;

  /// you can add more fields that meet your needs

  const CommonAppBar({super.key, this.title, this.appBar, this.widgets, this.centreTxt, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centreTxt,
      leading: leading == true?GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: fieldBorderColor,)):SizedBox(),
      title: MyTextWidget(data:title??"", size: 18, weight: FontWeight.w600, color: blackColor,),
      backgroundColor: whiteColor,
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(50);
}
