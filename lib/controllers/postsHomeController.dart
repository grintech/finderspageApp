import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/data/apiProvider/homeApiProvider.dart';
import 'package:projects/data/models/PostsListModel.dart';

import '../data/apiProvider/createPostApiProvider.dart';
import '../data/apiProvider/profileApiProvider.dart';
import '../data/models/userModel.dart';
import '../utils/helper/storageHelper.dart';
import '../utils/shared/dataResponse.dart';
import '../utils/util.dart';

class PostsHomeController extends GetxController with GetSingleTickerProviderStateMixin{
  var tabIndex = 0.obs;

  late TabController tabController;

  HomeApiProvider apiProvider = HomeApiProvider();
  RxList<PostsListModel> postsList=RxList();

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
    apiProvider = HomeApiProvider();
    tabController = TabController(length: 5, vsync: this);
    getPostLists();
  }

  Future<void> getPostLists() async {
    if (await Utils.hasNetwork()) {
      // Utils.showLoader();
      var response = await apiProvider.getAllPostList();
      // Utils.hideLoader();
      if (response.success == true) {
        postsList.addAll(response.data! as Iterable<PostsListModel>);
      }
      else {
        handleError(response);
      }
    } else {
      Utils.showErrorAlert("Please Check Your Internet Connection");
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