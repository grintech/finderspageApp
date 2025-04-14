import 'package:get/get.dart';
import 'package:projects/data/apiProvider/authApiProvider.dart';
import 'package:projects/data/models/userModel.dart';
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
          if(userModel.user?.verified_at != null) {
            storageHelper.saveUserModel(userModel);
            storageHelper.saveUserToken(userModel.token);
            storageHelper.saveUserId(userModel.user?.id);
            Get.offAllNamed(Routes.postsHome);
          }else{
            Utils.showInfoAlert("Please Verify your account. Check your email account.","");
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