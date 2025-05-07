import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/util.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
                      child: Icon(Icons.arrow_back_ios, color: fieldBorderColor,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Stack(
                      children: [
                        ImageView(height: 50, width: 50,),
                        Positioned(
                            bottom: 0, right: 0,
                            child: Container(
                          height: 15, width: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.more_vert),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (context, index){
              return Column(
                children: [
                  BubbleNormal(
                    text: 'this is sender',
                    isSender: true,
                    tail: true,
                    sent: true,
                    seen: true,
                    color: fieldBorderColor,
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ImageView(height: 30, width: 30,),
                      ),
                      BubbleNormal(
                        margin: EdgeInsets.only(left: 5, bottom: 15),
                        padding: EdgeInsets.only(left: 0),
                        text: 'this is receiver i am here for chatting screen this is sample text',
                        isSender: false,
                        tail: true,
                        color: greyColor,
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Message...",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Image.asset("assets/images/ic_clip.png", height: 25, width: 25,),
                SizedBox(width: 10,),
                Icon(Icons.send, color: fieldBorderColor, size: 28,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
