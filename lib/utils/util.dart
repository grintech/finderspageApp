import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cooler_alerts/cooler_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/utils/colorConstants.dart';

import '../controllers/createPostController.dart';
import '../controllers/postProfileController.dart';
final CreatePostController imagePickerController = Get.put(CreatePostController());
final PostProfileController profileController = Get.put(PostProfileController());

class MyTextWidget extends StatelessWidget {
  final String? data;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextOverflow? overflow;

  const MyTextWidget({super.key, this.data, this.size, this.color, this.weight, this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      data??"",
      style: TextStyle(
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
    );
  }

  static mediaOptions(){
    showModalBottomSheet(
        isDismissible: true,
        context: Get.context!,
        builder: (context){
          return Container(
            height: 100,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap:() {
                      imagePickerController.pickImage(ImageSource.camera);
                      Get.back();
                    },
                    child: Icon(Icons.camera, color: Colors.white,)),
                GestureDetector(
                    onTap:() {
                      imagePickerController.pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    child: Icon(Icons.perm_media_outlined, color: Colors.white,))
              ],
            ),
          );
        });
  }

  static showLog(String? log) {
    print("findersPage-log $log");
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
}