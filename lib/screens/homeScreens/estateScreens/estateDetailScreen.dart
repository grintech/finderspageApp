import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/util.dart';

import '../../../utils/colorConstants.dart';
import '../../../utils/commonWidgets/CommonAppBar.dart';

class EstateDetailScreen extends StatelessWidget {
  EstateDetailScreen({super.key});

  final _currentIndex = 0.obs;

  final List<String> productImages = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        centreTxt: true,
        title: "Estate Details",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 244,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        _currentIndex.value = index;
                      },
                    ),
                    items:
                    productImages.map((imagePath) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePath,
                          width: double.infinity,
                          height: 244,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
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
                  ),
                  Positioned(
                    right: 10,bottom: 5,
                    child: Container(
                    height: 30, width: 30,
                    decoration: BoxDecoration(
                      color: fieldBorderColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.bookmark, color: whiteColor, size: 20,),
                  ),),
                  Positioned(
                    bottom: 10,
                    child: Row(
                      children: productImages.asMap().entries.map((entry) {
                        int index = entry.key;
                        return Obx(()=>Container(
                          width: _currentIndex.value == index ? 25 : 25,
                          height: 10.0,
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                            _currentIndex.value == index
                                ? Color.fromARGB(255, 233, 121, 42)
                                : const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ));
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: MyTextWidget(data: "Model Home For Sale", size: 18, weight: FontWeight.w600,),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                margin: EdgeInsets.symmetric(vertical: 12),
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
                child: Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    MyTextWidget(data: "Price: ", size: 14, weight: FontWeight.w600,),
                                    MyTextWidget(data: "\$999.00", size: 12, weight: FontWeight.w500,)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      MyTextWidget(data: "Garage: ", size: 14, weight: FontWeight.w600,),
                                      MyTextWidget(data: "4", size: 12, weight: FontWeight.w500,)
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    MyTextWidget(data: "Units: ", size: 14, weight: FontWeight.w600,),
                                    MyTextWidget(data: "4", size: 12, weight: FontWeight.w500,)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      MyTextWidget(data: "Bathroom: ", size: 14, weight: FontWeight.w600,),
                                      MyTextWidget(data: "4", size: 12, weight: FontWeight.w500,)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(child: MyTextWidget(data: "apartment,furnished,house,laundry,town house", size: 12, weight: FontWeight.w500,))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(child: MyTextWidget(data: "4412 Fair Lakes Ct Fairfax, VA 22033", size: 12, weight: FontWeight.w500,))
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    MyTextWidget(data: "Posted By: ", size: 14, weight: FontWeight.w600,),
                                    MyTextWidget(data: "Collin Kendal", size: 12, weight: FontWeight.w500,)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: MyTextWidget(data: "Description", size: 16, weight: FontWeight.w600,),
              ),
              MyTextWidget(data: "Remote Role Remote Role Remote Role! Now that I have your attention "
                  "follow Shad's Video format on #chalkboardtalk on LinkedIn. Shad and his team at "
                  "Robert Half is working with an Oil Field Service Client that caters to the upstream "
                  "industry. ", size: 14, weight: FontWeight.w400,),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Stack(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
