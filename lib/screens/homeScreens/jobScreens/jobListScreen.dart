import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/CommonAppBar.dart';
import 'package:projects/utils/routes.dart';
import 'package:projects/utils/util.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        centreTxt: true,
        title: "Job Opportunities",
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
              child: GridView.builder(
                itemCount: 12,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.95
                  ),
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () => Get.toNamed(Routes.jobDetail),
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
                              height: 120, width: Get.width,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: MyTextWidget(data: "Remote Senior Financial Analyst Houston", size: 15,
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
