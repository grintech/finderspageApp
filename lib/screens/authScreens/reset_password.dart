import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';

import '../../utils/routes.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final newPassController = TextEditingController();
  final confPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset("assets/images/new_logo.png", width: 50),
              ),
              Container(
                height: 45,
                margin: EdgeInsets.only(top: 12, bottom: 15),
                color: purpleColor,
                child: Center(
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "New Password",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              CommonTextField(
                height: 45,
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                keyboardAction: TextInputAction.next,
                textController: newPassController,
                hint: "New Password",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, bottom: 10),
                child: Text(
                  "Confirm Password",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              CommonTextField(
                margin: EdgeInsets.only(left: 20, right: 20),
                keyboardAction: TextInputAction.done,
                textController: confPassController,
                hint: "Confirm Password",
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, right: 20, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/back-btn.png',
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: CommonButton(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.symmetric(horizontal: 42, vertical: 10),
                  radius: 50,
                  onPressed: () =>validate(),
                  btnTxt: "Submit",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void validate(){
    if(newPassController.text.isEmpty){
      Get.snackbar(backgroundColor: Color(0xFFDC7228), colorText: whiteColor, "Finders Page",
          "Please Enter New Password");
      return;
    }
    if(confPassController.text.isEmpty){
      Get.snackbar(backgroundColor: Color(0xFFDC7228), colorText: whiteColor, "Finders Page",
          "Your Password doesn't match");
      return;
    }
    if(newPassController.text != confPassController.text){
      Get.snackbar(backgroundColor: Color(0xFFDC7228), colorText: whiteColor, "Finders Page",
          "Your Password doesn't match");
      return;
    }
    Get.offAllNamed(Routes.loginRoute);
  }
}
