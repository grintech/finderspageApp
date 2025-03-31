import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/controllers/authController.dart';
import 'package:projects/data/models/userModel.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/CommonAppBar.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/routes.dart';

import '../../utils/util.dart';

class Login extends StatelessWidget {
  Login({super.key, required this.from});

  final showPass = true.obs;
  final String from;
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final getxController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: from == "welcome"?AppBar(
        automaticallyImplyLeading: false,
        // leading: GestureDetector(
        //     onTap: () => Get.back(),
        //     child: Icon(Icons.arrow_back_ios, color: fieldBorderColor,)),
        backgroundColor: blackColor,
      ):CommonAppBar(
        leading: true,
        background: blackColor,
      ),
      body: GestureDetector(
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Image.asset("assets/images/new_logo.png", width: 50),
                    ),
                  ),
                  Container(
                    height: 43,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(color: purpleColor),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 8),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                  ),
                  CommonTextField(
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    hint: "Enter email",
                    textController: emailController,
                    keyboardType: TextInputType.emailAddress,
                    keyboardAction: TextInputAction.next,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 8, top: 15),
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),

                  Obx(()=>CommonTextField(
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    hint: "Enter password",
                    obsTxt: showPass.value,
                    keyboardAction: TextInputAction.done,
                    textController: passController,
                    suffix: GestureDetector(
                      onTap: () {
                        showPass.value = !showPass.value;
                      },
                      child: showPass.value?Icon(Icons.visibility_off):Icon(Icons.visibility),
                    ),
                  ),),

                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.forgetPasswordRoute);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 8, bottom: 20),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: blackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: CommonButton(
                      onPressed: () {
                        validate();
                      },
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      btnTxt: "Login",
                      radius: 50,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.signupRoute, arguments: "login");
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "Sign up",
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

                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
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
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset("assets/images/facebook-icon.png"),
                          iconSize: 32,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Image.asset("assets/images/google-icon.png"),
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
    );
  }
  void validate(){
    if(emailController.text.isEmpty){
      Get.snackbar(backgroundColor: Color(0xFFDC7228), colorText: whiteColor, "Finders Page", "Please Enter Your Email");
      return;
    }
    if (!Utils.isValidEmail(emailController.text.toString().trim())) {
      Utils.error("Please enter valid Email");
      return;
    }
    if(passController.text.isEmpty){
     Utils.error("Please enter password");
      return;
    }

    Get.offAllNamed(Routes.postsHome);

    // getxController.login(UserModel(
    //   email: emailController.text.toString(),
    //   password: passController.text.toString()
    // ));

  }
}
