import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsHomeController extends GetxController with GetSingleTickerProviderStateMixin{
  var tabIndex = 0.obs;

  late TabController tabController;

  var currentIndex = 0.obs;


  updateIndexValue(value){
    currentIndex.value = value;
  }


  changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
  }

}