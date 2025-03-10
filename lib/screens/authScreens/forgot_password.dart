import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/routes.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 20),
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
                  margin: EdgeInsets.only(top: 12),
                  height: 45,
                  color: purpleColor,
                  child: Center(
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Email Field
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                CommonTextField(
                  height: 45,
                  textController: emailController,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  keyboardType: TextInputType.emailAddress,
                  keyboardAction: TextInputAction.done,
                  hint: "Enter Email",
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 20, top: 6),
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
                    onPressed: () {
                      if(emailController.text.isEmpty){
                        Get.snackbar(backgroundColor: Color(0xFFDC7228), colorText: whiteColor, "Finders Page", "Please Enter Your Email");
                        return;
                      }
                      Get.toNamed(Routes.resetPasswordRoute);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 42, vertical: 10),
                    radius: 50,
                    btnTxt: "Submit",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
