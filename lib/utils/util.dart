import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cooler_alerts/cooler_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:mime/mime.dart';
import '../controllers/createPostController.dart';
import '../controllers/postProfileController.dart';
final CreatePostController imagePickerController = Get.put(CreatePostController());
final PostProfileController profileController = Get.put(PostProfileController());

class MyTextWidget extends StatelessWidget {
  final String? data;
  final double? size;
  final FontWeight? weight;
  final TextAlign? txtAlign;
  final TextDecoration? txtDecoration;
  final Color? color;
  final Color? decoColor;
  final TextOverflow? overflow;


  const MyTextWidget({super.key, this.data, this.size, this.color, this.weight, this.overflow, this.txtAlign, this.txtDecoration, this.decoColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      data??"",
      textAlign: txtAlign,
      style: TextStyle(
        decoration: txtDecoration,
          decorationColor: decoColor,
          color: color ?? blackColor,
          overflow: overflow,
          fontSize: size ?? 14.0,
          fontWeight: weight
      ),
    );
  }
}

class Utils{
  static error(String? message) {
    if (message == null) {
      return;
    }
    Get.closeAllSnackbars();
    Get.snackbar(
      "",
      message,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 4),
      backgroundColor: fieldBorderColor,
      borderRadius: 10,
      snackPosition: SnackPosition.TOP,
      colorText: blackColor,
      titleText: const Text(
        "",
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 2,
        ),
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 17,
            height: 1.4),
      ),
      duration: Duration(seconds: 2)
    );
  }

  static mediaOptions() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await imagePickerController.pickImage(ImageSource.camera);
                          Get.back();
                        },
                        child: Column(
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.3, 1.0], // 30% and 100%
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x194A841C),
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 19,
                                    ),
                                  ],
                                ),
                                child: Icon(Icons.camera_alt, color: whiteColor,)),
                            SizedBox(height: 10,),
                            MyTextWidget(data: "Camera")
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await imagePickerController.pickImage(ImageSource.gallery);
                          Get.back();
                        },
                        child: Column(
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.3, 1.0], // 30% and 100%
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x194A841C),
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 19,
                                    ),
                                  ],
                                ),
                                child: Icon(Icons.perm_media_outlined, color: whiteColor,)),
                            SizedBox(height: 10,),
                            MyTextWidget(data: "Gallery")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await imagePickerController.pickVideo(ImageSource.gallery);
                      Get.back();
                    },
                    child: Column(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.3, 1.0], // 30% and 100%
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x194A841C),
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 19,
                                ),
                              ],
                            ),
                            child: Icon(Icons.video_camera_back_outlined, color: whiteColor,)),
                        SizedBox(height: 10,),
                        MyTextWidget(data: "Videos")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  static showLog(String? log) {
    print("findersPage-log $log");
  }

  static String? getFileType(String path) {
    final mimeType = lookupMimeType(path);
    String? result = mimeType?.substring(0, mimeType.indexOf('/'));
    return result;
  }

  static Future<bool> hasNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Utils.showErrorAlert("Check Your Internet Connection");
      return false;
    } else {
      return true;
    }
  }

  static bool isValidEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  static showErrorAlert(String? error) {
    CoolerAlerts.show(
      context: Get.context!,
      type: CoolAlertType.error,
      title: 'Error',
      text: _extractText(error),
      confirmBtnColor: fieldBorderColor,
      loopAnimation: false,
      backgroundColor: fieldBorderColor,
    );
  }

  static showErrorMsgAlert(String title,String error) {
    CoolerAlerts.show(
      context: Get.context!,
      type: CoolAlertType.error,
      title: title,
      text: _extractText(error),
      confirmBtnColor: fieldBorderColor,
      loopAnimation: false,
      backgroundColor: fieldBorderColor,
    );
  }

  static showSuccessAlert(String message) {
    CoolerAlerts.show(
      context: Get.context!,
      title: "Success",
      type: CoolAlertType.success,
      text: _extractText(message),
      backgroundColor: fieldBorderColor,
    );
  }

  static showInfoAlert(String message,String? title) {
    CoolerAlerts.show(
      context: Get.context!,
      type: CoolAlertType.warning,
      title: title??"Info",
      text: _extractText(message),
    );
  }

  static showLoader({String? msg}) {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.clear,
      status: msg ?? "",
      dismissOnTap: false,
    );
  }

  static Future hideLoader() async {
    return await EasyLoading.dismiss();
  }

  static String _extractText(String? message) {
    if (message == null) {
      return "";
    }
    if (message.length > 200) {
      return message.substring(0, 199);
    } else {
      return message;
    }
  }
  String removeHtmlTags(String htmlText) {
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}