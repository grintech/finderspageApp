import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

}