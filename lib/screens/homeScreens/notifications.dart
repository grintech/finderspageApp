import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/postsHomeController.dart';
import 'package:projects/data/apiConstants.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/helper/dateHelper.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:projects/utils/util.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key,});

  final controller = Get.put(PostsHomeController());

  var turnOn = false.obs;

  @override
  Widget build(BuildContext context) {
    controller.notificationApi(StorageHelper().getUserId()!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white, 
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child:Icon(Icons.arrow_back_ios, color: fieldBorderColor,)
        ),
        actions: [
          PopupMenuButton<int>(
              color: whiteColor,
              surfaceTintColor: whiteColor,
              icon: Icon(Icons.more_vert, color: blackColor, size: 20,),
              offset: Offset(-12, 35),
              menuPadding: EdgeInsets.zero,
              itemBuilder: (context){
                return <PopupMenuEntry<int>>[
                  PopupMenuItem(
                    onTap: (){
                      controller.clearNotificationApi(StorageHelper().getUserId()!);
                      controller.notificationApi(StorageHelper().getUserId()!);
                      // Get.back();
                    },
                    padding: EdgeInsets.only(left: 10),
                    value: 0,
                    child: Text("Clear All Notifications"),),
                ];
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(()=>
        controller.notificationList.isEmpty?
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(child: Column(
                children: [
                  Image.asset("assets/images/no_notification.png", scale: 1.5,),
                  MyTextWidget(data: "No New Notifications found", size: 16, weight: FontWeight.w600,),
                ],
              )),
            ):
                  ListView.builder(
                  itemCount: controller.notificationList.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = controller.notificationList[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        border: const Border(
                          left: BorderSide(color: Color(0xFFDC7228), width: 4),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          item.image == null
                              ? Image.asset(
                            'assets/images/new_logo.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Image.network(
                              "${ApiConstants.profileUrl}/${item.image}",
                              width: 35,
                              height: 40,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.message ?? "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(DateHelper().convertToTimeAgo(item.created??""),
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
