import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/apiProvider/profileApiProvider.dart';
import '../data/models/userModel.dart';
import '../utils/helper/storageHelper.dart';
import '../utils/shared/dataResponse.dart';
import '../utils/util.dart';

class PostsHomeController extends GetxController with GetSingleTickerProviderStateMixin{
  var tabIndex = 0.obs;

  late TabController tabController;
  late ProfileApiProvider _profileApiProvider = ProfileApiProvider();
  late StorageHelper storageHelper = StorageHelper();

  Rxn<UserModel> userModel = Rxn();

  var currentIndex = 0.obs;
  var isVideoScreenActive = false.obs;


  updateIndexValue(value){
    currentIndex.value = value;
  }


  void changeTabIndex(int index) {
    isVideoScreenActive.value = (index == 1); // Check if VideoFeedScreen is active
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    _profileApiProvider = ProfileApiProvider();
    storageHelper = StorageHelper();
    tabController = TabController(length: 5, vsync: this);
    // Future.delayed(Duration(seconds: 2), () {
    //   if(storageHelper.getUserModel()?.user?.id !=null){
    //     getProfileApi();
    //   }
    // });
  }

  // Future<void> getProfileApi()async{
  //   if(await Utils.hasNetwork()){
  //     var res = await _profileApiProvider.getUserApi();
  //     var dataResponse = res as DataResponse;
  //     if(dataResponse.success == true){
  //       var userModel = dataResponse.data as UserModel;
  //       storageHelper.saveUserId(userModel.user?.id);
  //       storageHelper.saveUserModel(userModel);
  //       this.userModel.value = userModel;
  //       this.userModel.refresh();
  //     }else{
  //       handleError(dataResponse);
  //     }
  //   }
  // }
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