import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/util.dart';

import '../../utils/routes.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap:(){
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios, color: fieldBorderColor,)),
                  SizedBox(width: 30,),
                  MyTextWidget(data: "Messges", size: 18, weight: FontWeight.w600,)
                ],
              ),
              Icon(Icons.more_vert, color: blackColor,)
            ],
          ),
          ),
          CommonTextField(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            hint: "Search User",
            suffix: Icon(Icons.search, color: fieldBorderColor,),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index){
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.chat);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ImageView(height: 50, width: 50,),
                        ),
                        SizedBox(width: 20,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MyTextWidget(data: "UserName",size: 16, weight: FontWeight.w600,),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: MyTextWidget(data: "4 min ago", size: 10,),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4,),
                              MyTextWidget(data: "this is last message", size: 14, weight: FontWeight.w500,),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12,)
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
