import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/authController.dart';
import 'package:projects/data/models/userModel.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/routes.dart';

import '../../data/models/signupModel.dart';
import '../../utils/util.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final showPass = true.obs;
  final confPass = true.obs;

  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confPassController = TextEditingController();

  final controller = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusScopeNode());
          },
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset("assets/images/new_logo.png", width: 50),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(color: purpleColor),
                      child: Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                    CommonTextField(
                      height: 45,
                      keyboardAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      textController: nameController,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      hint: "Name",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8),
                      child: Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                    CommonTextField(
                      height: 45,
                      keyboardAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      textController: userNameController,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      hint: "Username",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                    CommonTextField(
                      height: 45,
                      textController: emailController,
                      keyboardAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      margin: EdgeInsets.only(left: 20, bottom: 8, right: 20),
                      hint: "Email",
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                    Obx(()=>CommonTextField(
                      height: 45,
                      margin: EdgeInsets.only(left: 20, bottom: 8, right: 20),
                      hint: "Password",
                      keyboardAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      obsTxt: showPass.value,
                      textController: passController,
                      suffix: GestureDetector(
                        onTap: () {
                          showPass.value = !showPass.value;
                        },
                        child: showPass.value?Icon(Icons.visibility_off):Icon(Icons.visibility),
                      ),
                    ),),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                   Obx(()=> CommonTextField(
                     height: 45,
                     keyboardAction: TextInputAction.done,
                     keyboardType: TextInputType.text,
                     margin: EdgeInsets.only(left: 20, bottom: 8, right: 20),
                     hint: "Confirm Password",
                     textController: confPassController,
                     obsTxt: confPass.value,
                     suffix: GestureDetector(
                       onTap: () {
                         confPass.value = !confPass.value;
                       },
                       child: confPass.value?Icon(Icons.visibility_off):Icon(Icons.visibility),
                     ),
                   ),),

                    Center(
                      child: CommonButton(
                        radius: 50,
                        onPressed: () => validate(),
                        margin: EdgeInsets.only(top: 25, bottom: 22),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        btnTxt: "Sign up",
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Already have an account? ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                      decorationColor: blackColor,
                                    ),
                                  )
                                ]
                            ),),
                        ),
                      ),
                    ),

                    // "Or" Text
                    Center(
                      child: Text(
                        "Or",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                        child: Text(
                          "Login with",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    // Social Login Buttons
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset("assets/images/facebook-icon.png"),
                            ),
                            iconSize: 32,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset("assets/images/google-icon.png"),
                            ),
                            iconSize: 32,
                            onPressed: () {},
                          ),
                          if(Platform.isIOS)
                            IconButton(
                              icon: Image.asset("assets/images/ic_apple.png", height: 36, width: 36,),
                              iconSize: 32,
                              onPressed: () {},
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void validate(){
    if(emailController.text.isEmpty){
      Utils.error("Please enter your email");
      return;
    }
    if (!Utils.isValidEmail(emailController.text.toString().trim())) {
      Utils.error("Please enter valid Email");
      return;
    }
    if(passController.text.isEmpty){
      Utils.error("Please enter your password");
      return;
    }
    if(confPassController.text.isEmpty){
      Utils.error("Password doesn't matched");
      return;
    }
    if(passController.text != confPassController.text){
      Utils.error("Password doesn't matched");
      return;
    }
    if(nameController.text.isEmpty) {
      Utils.error("Please enter your name");
      return;
    }
    controller.signup(SignupModel(
      firstName:nameController.text,
      username: userNameController.text,
      email: emailController.text,
      password: passController.text,
    ));

  }
}
