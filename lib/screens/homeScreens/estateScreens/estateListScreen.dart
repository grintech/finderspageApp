import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/util.dart';

import '../../../utils/colorConstants.dart';
import '../../../utils/commonWidgets/CommonAppBar.dart';
import '../../../utils/routes.dart';

class EstateListScreen extends StatelessWidget {
  const EstateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        centreTxt: true,
        title: "Real Estate",
        widgets: [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/filter.png',
                width: 25,
                height: 25,
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusScopeNode());
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
              child: Row(
                children: [
                  Container(
                    height: 58,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(5),
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
                  SizedBox(width: 10),
                  // Search Input
                  Expanded(
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: searchBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 18,
                                  horizontal: 10,
                                ),
                                border:
                                InputBorder.none,
                              ),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: 10,
                            ),
                            child: Icon(Icons.search, color: Color(0xAAA54DB7)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () => Get.toNamed(Routes.estateDetail),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: fieldBorderColor),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/images/image1.png", height: 100, width: 120,),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyTextWidget(data: "Model Home For Sale", size: 16, weight: FontWeight.w600,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextWidget(data: "4 BHK", size: 16, weight: FontWeight.w500,),
                                      MyTextWidget(data: "16 Days Ago", size: 16, weight: FontWeight.w500,),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyTextWidget(data: "\$500.00", size: 16, weight: FontWeight.w500,),
                                    MyTextWidget(data: "+919417185951", size: 16, weight: FontWeight.w500,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
