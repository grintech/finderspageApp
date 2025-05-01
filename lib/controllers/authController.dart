import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/data/apiProvider/authApiProvider.dart';
import 'package:projects/data/models/userModel.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:projects/utils/shared/dataResponse.dart';
import '../utils/routes.dart';
import '../utils/util.dart';

class AuthController extends GetxController{

  late AuthApiProvider _authApiProvider = AuthApiProvider();
  late StorageHelper storageHelper = StorageHelper();

  @override
  void onInit() {
    _authApiProvider = AuthApiProvider();
    storageHelper = StorageHelper();
    super.onInit();
  }

  Future<void> login(UserModel model)async{
    if(await Utils.hasNetwork()){
      Utils.showLoader();
      var res= await _authApiProvider.signIn(model);
      Utils.hideLoader();
      var response = res as DataResponse;
      if(response.success==true){
        var userModel = UserModel();
        if(response.data != null){
          userModel = response.data as UserModel;
          storageHelper.saveUserModel(userModel);
          storageHelper.saveUserToken(userModel.token);
          storageHelper.saveUserId(userModel.user?.id);
          if(userModel.user?.verified_at != null) {
            Get.offAllNamed(Routes.postsHome);
          }
          else{
            Get.dialog(
              Center(
                child: Container(
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyTextWidget(data: "Confirm Your Email", weight: FontWeight.w600, size: 18,),
                      SizedBox(height: 10,),
                      MyTextWidget(data: "We’ve emailed you a verification link to complete your sign-up.", txtAlign: TextAlign.center, size: 14, weight: FontWeight.w400,),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          resend(UserModel(
                            id: storageHelper.getUserId()
                          ));
                          Get.back();
                        },
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                          children: [
                            TextSpan(text: "If the link expired or you didn’t get the email, you can "
                                "request a new one. ",style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: blackColor,
                            ),),
                            TextSpan(
                              text: "Resend Verification Link",style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: fieldBorderColor,
                            ),)
                          ]
                        )),
                      )
                    ],
                  ),
                ),
              )
            );
          }
        }
      }else{
        handleError(response);
      }
    }else{
      Utils.showErrorAlert("Please check internet connection");
    }
  }

  Future<void> signup(UserModel model)async{
    if(await Utils.hasNetwork()){
      Utils.showLoader();
      print("my data --- > ${model.toJson()}");
      var res= await _authApiProvider.signUp(model);
      Utils.hideLoader();
      var response = res as DataResponse;
      if(response.success == true){
        var userModel = response.data as UserModel;
        if(response.data != null){
          storageHelper.saveUserToken(userModel.token);
          Utils.showSuccessAlert("${response.message}");
          Future.delayed(const Duration(seconds: 3), () {
            Get.offAllNamed(Routes.loginRoute);
          });
        }
      }else{
        handleError(response);
      }
    }else{
      Utils.showErrorAlert("Please check internet connection");
    }
  }

  Future<void> forgot(UserModel model) async {
    if (await Utils.hasNetwork()) {
      Utils.showLoader();
      var response = await _authApiProvider.forgot(model);
      Utils.hideLoader();

      var dataResponse = response as DataResponse;
      if (dataResponse.success == true) {
        Utils.error(dataResponse.message);
        // _preferenceHelper.saveUserId(userModel.id);
        // openVerificationScreen(model, "forgot");
        Get.offAllNamed(Routes.loginRoute);
      } else {
        handleError(dataResponse);
      }
    } else {
      Utils.showErrorAlert("Please check your internet connection");
    }
  }

  Future<void> resend(UserModel model) async {
    if (await Utils.hasNetwork()) {
      Utils.showLoader();
      var response = await _authApiProvider.resend(model);
      Utils.hideLoader();

      var dataResponse = response as DataResponse;
      if (dataResponse.success == true) {
        Utils.showSuccessAlert(dataResponse.message!);
      } else {
        handleError(dataResponse);
      }
    } else {
      Utils.showErrorAlert("Please check your internet connection");
    }
  }


  void handleError(dynamic response) {
    if (response.message != null) {
      Utils.showErrorAlert(response.message);
    } else if (response.error != null) {
      Utils.showErrorAlert(response.error);
    } else {
      Utils.showErrorAlert("Server Error. Please Try Again");
    }
  }
}