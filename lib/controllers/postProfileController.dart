import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/data/apiProvider/profileApiProvider.dart';
import 'package:projects/data/models/userModel.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:projects/utils/routes.dart';
import 'package:projects/utils/shared/dataResponse.dart';
import 'package:path/path.dart' as path;
import '../utils/util.dart';

class PostProfileController extends GetxController {

  late ProfileApiProvider _profileApiProvider = ProfileApiProvider();
  late StorageHelper storageHelper = StorageHelper();

  var coverImagePath = ''.obs;
  var profileImagePath = ''.obs;
  var profileImageFile = ''.obs;
  var dateOfBirth = ''.obs;
  var selectedDOB = Rxn<DateTime>();
  Rxn<UserModel> userModel = Rxn();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final zipController = TextEditingController();
  final bioController = TextEditingController();


  @override
  void onInit() {
    _profileApiProvider = ProfileApiProvider();
    storageHelper = StorageHelper();
   Future.delayed(Duration(milliseconds: 200),(){
     if(storageHelper.getUserModel()?.user?.id !=null){
       getProfileApi();
     }
   });
    super.onInit();
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      coverImagePath.value = image.path;
    }
    // else {
    //   Get.snackbar("Error", "No image selected",
    //       snackPosition: SnackPosition.BOTTOM);
    // }
  }
  Future<void> pickProfileImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      profileImagePath.value = image.path;
    }
    // else {
    //   Get.snackbar("Error", "No image selected",
    //       snackPosition: SnackPosition.BOTTOM);
    // }
  }

  void selectCoverImage(){
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
                      pickImage(ImageSource.camera);
                      Get.back();
                    },
                    child: Icon(Icons.camera, color: Colors.white,)),
                GestureDetector(
                    onTap:() {
                      pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    child: Icon(Icons.perm_media_outlined, color: Colors.white,))
              ],
            ),
          );
        });
  }

  void selectProfileImage(){
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
                      pickProfileImage(ImageSource.camera);
                      Get.back();
                    },
                    child: Icon(Icons.camera, color: Colors.white,)),
                GestureDetector(
                    onTap:() {
                      pickProfileImage(ImageSource.gallery);
                      Get.back();
                    },
                    child: Icon(Icons.perm_media_outlined, color: Colors.white,))
              ],
            ),
          );
        });
  }

  Future<void> getProfileApi()async{
    if(await Utils.hasNetwork()){
      var res = await _profileApiProvider.getUserApi();
      var dataResponse = res as DataResponse;
      if(dataResponse.success == true){
        var userModel = dataResponse.data as UserModel;
        storageHelper.saveUserId(userModel.user?.id);
        storageHelper.saveUserModel(userModel);
        this.userModel.value = userModel;
        this.userModel.refresh();
        if (userModel.user?.first_name != null) {
          nameController.text = userModel.user!.first_name!;
        }
        if (userModel.user?.email != null) {
          emailController.text = userModel.user!.email!;
        }
        if (userModel.user?.username != null) {
          usernameController.text = userModel.user!.username!;
        }
        if (userModel.user?.phonenumber != null) {
          phoneController.text = userModel.user!.phonenumber!;
        }
        if (userModel.user?.zipcode != null) {
          zipController.text = userModel.user!.zipcode!;
        }
        // if(userModel.user?.dob != null){
        //   selectedDOB = userModel.user?.dob;
        // }
        if (userModel.user?.bio != null) {
          String bioHtml = userModel.user!.bio!;
          String plainTxt = Utils().removeHtmlTags(bioHtml);
          bioController.text = plainTxt;
        }
      }else{
        handleError(dataResponse);
      }
    }
  }

  Future<void> updateUserApi(UserModel userModel) async {
    if (await Utils.hasNetwork()) {
      print("show Data -----> ${userModel.toJson()}");
        Utils.showLoader();
      var response = await _profileApiProvider.updateProfileApi(userModel);
      Utils.hideLoader();
      var dataResponse = response as DataResponse;
      if (dataResponse.success == true) {

        var userModel = dataResponse.data as UserModel;
        this.userModel.value = userModel;
        getProfileApi();
        Get.back();
      } else {
        handleError(dataResponse);
      }
    } else {
      Utils.showErrorAlert("Please Check Your Internet Connection");
    }
  }

  Future<void> logOut()async{
    if(await Utils.hasNetwork()){
      // Utils.showLoader();
      // var res = await _profileApiProvider.logOut();
      // Utils.hideLoader();
      // var response = res as DataResponse;
      // if(response.success==true){
        storageHelper.clearAll();
        Get.offAllNamed(Routes.loginRoute);
      // }
    }
    // else{
    //   handleError(response);
    // }
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