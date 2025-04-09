import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/apiProvider/createPostApiProvider.dart';
import '../data/apiProvider/profileApiProvider.dart';
import '../data/models/userModel.dart';
import '../utils/helper/storageHelper.dart';
import '../utils/shared/dataResponse.dart';
import '../utils/util.dart';

class PostsHomeController extends GetxController with GetSingleTickerProviderStateMixin{
  var tabIndex = 0.obs;

  late TabController tabController;


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

    tabController = TabController(length: 5, vsync: this);
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