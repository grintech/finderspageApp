import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key,});



  @override
  Widget build(BuildContext context) {
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 9,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 55,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 1), 
                        ),
                      ],
                      border: const Border(left: BorderSide(color: Color(0xFFDC7228), width: 4,),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/new_logo.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Lorem Ipsum is dummy text",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "1 day ago",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
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
          ],
        ),
      ),
    );
  }
}
