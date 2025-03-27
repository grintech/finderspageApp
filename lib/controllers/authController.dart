import 'package:get/get.dart';
import 'package:projects/data/apiProvider/authApiProvider.dart';
import 'package:projects/data/models/userModel.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:projects/utils/shared/dataResponse.dart';

import '../utils/routes.dart';
import '../utils/util.dart';

class AuthController extends GetxController{

  late AuthApiProvider authApiProvider;
  late StorageHelper storageHelper;

  @override
  void onInit() {
    authApiProvider = AuthApiProvider();
    storageHelper = StorageHelper();
    super.onInit();
  }

  Future<void> login(UserModel model)async{
    if(await Utils.hasNetwork()){
      var res= await authApiProvider.signIn(model);
      var response = res as DataResponse;
      if(response.success==true){
        var userModel = UserModel();
        if(response.data != null){
          userModel = response.data as UserModel;
          storageHelper.saveUserModel(userModel);
          // storageHelper.saveUserType(userModel.userType);
          storageHelper.saveUserToken(userModel.token);
          // storageHelper.saveUserId(userModel.id);
          Get.offAllNamed(Routes.postsHome);
        }
      }else{
        handleError(response);
      }
    }
  }

  Future<void> signup(UserModel model)async{
    if(await Utils.hasNetwork()){
      var res= await authApiProvider.signUp(model);
      var response = res as DataResponse;

      if(response.success == true){
        var userModel = UserModel();
        if(response.data != null){
          userModel = response.data as UserModel;
          Get.offAllNamed(Routes.postsHome);
        }
      }else{
        handleError(response);
      }
    }
  }

  void handleError(dynamic response) {
    if (response.message != null) {
      // Utils.showErrorAlert(response.message);
    } else if (response.error != null) {
      // Utils.showErrorAlert(response.error);
    } else {
      // Utils.showErrorAlert("Server Error. Please Try Again");
    }
  }
}