import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/data/apiProvider/homeApiProvider.dart';
import 'package:projects/data/models/PostsListModel.dart';
import '../utils/routes.dart';
import '../utils/util.dart';

class PostsHomeController extends GetxController{
  var tabIndex = 0.obs;

  late TabController tabController;

  HomeApiProvider apiProvider = HomeApiProvider();
  RxList<PostsListModel> postsList=RxList();
  RxList<PostsListModel> videoList=RxList();
  RxList<String> videoUrls = <String>[].obs;

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
    getPostLists();
    Future.delayed(Duration(seconds: 5),() {
      getVideoLists();
    });
  }

  Future<void> getPostLists() async {
    if (await Utils.hasNetwork()) {
      Map<String, dynamic> queries = HashMap();
      //queries['filter'] = 'inReview';
      queries['page'] = 1;
      queries['per_page'] = 10;
      // Utils.showLoader();
      var response = await apiProvider.getAllPostList(queries);
      // Utils.hideLoader();
      if (response.success == true) {
        postsList.clear();
        postsList.addAll(response.data! as Iterable<PostsListModel>);

      }
      else {
        handleError(response);
      }
    } else {
      Utils.showErrorAlert("Please Check Your Internet Connection");
    }
  }


  Future<void> getVideoLists() async {
    if (await Utils.hasNetwork()) {
      // Utils.showLoader();
      var response = await apiProvider.getAllVideoList();
      // Utils.hideLoader();
      if (response.success == true) {
        videoList.clear();
        videoList.addAll(response.data! as Iterable<PostsListModel>);
        extractFirstVideoUrls();

      }
      else {
        handleError(response);
      }
    } else {
      Utils.showErrorAlert("Please Check Your Internet Connection");
    }
  }

  void extractFirstVideoUrls() {
    videoUrls.clear();
    for (var post in videoList) {
      if (post.postVideo != null && post.postVideo!.isNotEmpty) {
        try {
          List<dynamic> parsed = json.decode(post.postVideo!);
          if (parsed.isNotEmpty) {
            videoUrls.add(parsed.first);
          }
        } catch (e) {
          print('Error decoding post_video: $e');
        }
      }
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