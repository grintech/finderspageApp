import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/CommonAppBar.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/util.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        centreTxt: true,
        title: "Job Details",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset("assets/images/image1.png", height: 220, width: Get.width,fit: BoxFit.fill,),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      height: 30, width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: fieldBorderColor,
                      ),
                      child: Icon(Icons.flag_outlined, color: whiteColor, size: 20,),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: MyTextWidget(data: "Remote Senior Financial Analyst Houston", size: 20, weight: FontWeight.w600,),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x56000000),
                      offset: Offset(5, 8),
                      blurRadius: 10,
                      spreadRadius: 3
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            MyTextWidget(data: "\$70k - 18 lpa")
                          ],
                        ),
                        Row(
                          children: [
                            MyTextWidget(data: "Full Time")
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              MyTextWidget(data: "Posted By: ", size: 14, weight: FontWeight.w600,),
                              MyTextWidget(data: "Robert Half", size: 12, weight: FontWeight.w400,)
                            ],
                          ),
                          Row(
                            children: [
                              MyTextWidget(data: "Posted: ", size: 14, weight: FontWeight.w600,),
                              MyTextWidget(data: "16 Days ago", size: 12, weight: FontWeight.w400,)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              color: fieldBorderColor,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.bookmark, color: whiteColor, size: 20,),
                              SizedBox(width: 6,),
                              MyTextWidget(data: "Save Job", size: 14, weight: FontWeight.w600, color: whiteColor,)
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: fieldBorderColor,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: MyTextWidget(data: "Apply For Job", size: 14, weight: FontWeight.w600, color: whiteColor,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 4),
                child: MyTextWidget(data: "Description", size: 16, weight: FontWeight.w600,),
              ),
              MyTextWidget(data: "Remote Role Remote Role Remote Role! Now that I have your attention "
                  "follow Shad's Video format on #chalkboardtalk on LinkedIn. Shad and his team at "
                  "Robert Half is working with an Oil Field Service Client that caters to the upstream "
                  "industry. ", size: 14, weight: FontWeight.w400,),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4),
                child: MyTextWidget(data: "Requirements", size: 16, weight: FontWeight.w600,),
              ),
              for(int i = 0; i<4; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: MyTextWidget(data: "Remote Financial Reporting Role - Must be local to Houston", size: 14, weight: FontWeight.w600,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: "https://www.roberthalf.com/us/en/jobs/all/remote",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: fieldBorderColor),
                      recognizer: TapGestureRecognizer()..onTap =(){
                        launchUrl(Uri.parse("https://www.roberthalf.com/us/en/jobs/all/remote"));
                      }
                    )
                  ]
                )),
              ),

              Stack(
                children: [
                  Image.asset("assets/images/gmaps.png", height: 200, width: Get.width, fit: BoxFit.fill),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      height: 35, width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.3, 1.0], // 30% and 100%
                        ),
                      ),
                      child: Icon(Icons.thumb_up_off_alt, color: whiteColor,),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
