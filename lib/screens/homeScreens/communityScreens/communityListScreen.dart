import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colorConstants.dart';
import '../../../utils/commonWidgets/CommonAppBar.dart';
import '../../../utils/routes.dart';
import '../../../utils/util.dart';

class CommunityListScreen extends StatelessWidget {
  CommunityListScreen({super.key});

  final showSearch = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        leading: true,
        centreTxt: false,
        title: "",
        widgets: [
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: MyTextWidget(data: "Community Ads", size: 16, weight: FontWeight.w600,),
          ),
          Spacer(),
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 12,),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(8),
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
          GestureDetector(
            onTap: () {
              showSearch.value = !showSearch.value;
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 20),
              child: Icon(Icons.search, color: fieldBorderColor, size: 26,),
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
            Obx(()=> Visibility(
              visible: !showSearch.value,
              child: Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: searchBorderColor,
                    width: 1,
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),),
            Expanded(
              child: GridView.builder(
                  itemCount: 4,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.92
                  ),
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () => Get.toNamed(Routes.communityDetail),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: fieldBorderColor),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/image1.png",fit: BoxFit.fill,
                              height: 100, width: Get.width,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: MyTextWidget(data: "Welcome to Community", size: 15,
                                weight: FontWeight.w600, overflow: TextOverflow.ellipsis,),
                            ),
                            MyTextWidget(data: "15 Days ago", size: 10, weight: FontWeight.w500,)
                          ],
                        ),
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
