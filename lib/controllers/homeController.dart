import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/data/apiProvider/homeApiProvider.dart';
import 'package:projects/data/models/shopModel.dart';
import 'package:projects/utils/helper/storageHelper.dart';

import '../data/models/userModel.dart';
import '../utils/util.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{
  var tabIndex = 0.obs;
  late TabController tabController;
  late HomeApiProvider apiProvider;

  var currentIndex = 0.obs;
  RxList<UserModel> categoryList=RxList();
  RxList<ShopModel> shopList=RxList();


  updateIndexValue(value){
    currentIndex.value = value;
  }


  changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    apiProvider = HomeApiProvider();
    tabController = TabController(length: 4, vsync: this);
    getHomeCategories();
    getShopListApi();
    super.onInit();
  }


  Future<void> getHomeCategories() async {
    if (await Utils.hasNetwork()) {
    // Utils.showLoader();
    var response = await apiProvider.getHomeList();
    // Utils.hideLoader();
    if (response.success == true) {
      categoryList.addAll(response.data! as Iterable<UserModel>);
    }
     else {
    handleError(response);
    }
    } else {
    // Utils.showErrorAlert("Please Check Your Internet Connection");
    }
  }

  Future<void> getShopListApi() async {
    if (await Utils.hasNetwork()) {
    // Utils.showLoader();
    var response = await apiProvider.getShopList();
    // Utils.hideLoader();
    if (response.success == true) {
      shopList.addAll(response.data! as Iterable<ShopModel>);
    }
     else {
    handleError(response);
    }
    } else {
    // Utils.showErrorAlert("Please Check Your Internet Connection");
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