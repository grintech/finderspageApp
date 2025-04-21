import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/data/apiProvider/homeApiProvider.dart';
import 'package:projects/data/models/PostsListModel.dart';
import 'package:projects/data/models/comReplyModel.dart';
import 'package:projects/data/models/commentListModel.dart';
import 'package:projects/data/models/commentModel.dart';
import 'package:projects/data/models/likeModel.dart';
import 'package:projects/utils/shared/dataResponse.dart';
import '../utils/routes.dart';
import '../utils/util.dart';

class PostsHomeController extends GetxController{
  var tabIndex = 0.obs;

  late TabController tabController;

  HomeApiProvider apiProvider = HomeApiProvider();
  RxList<PostsListModel> postsList=RxList();
  RxList<PostsListModel> videoList=RxList();
  RxList<CommentListModel> commentList=RxList();
  RxList<ComReplyModel> replyList=RxList();
  RxSet<int> expandedReplies = <int>{}.obs;
  RxList<String> videoUrls = <String>[].obs;

  var commentLikeStates = <int, RxBool>{};
  var commentLikesCount = <int, RxInt>{};

  Rxn<PostsListModel> postModel = Rxn();

  var currentIndex = 0.obs;
  var isVideoScreenActive = false.obs;
  RxMap<int, List<ComReplyModel>> replyMap = <int, List<ComReplyModel>>{}.obs; // reply list per comment


  updateIndexValue(value){
    currentIndex.value = value;
  }


  void changeTabIndex(int index) {
    isVideoScreenActive.value = (index == 1); // Check if VideoFeedScreen is active
    tabIndex.value = index;
  }

  // void toggleLike(int? commentId, String currentUserId, String likedByJson) {
  //   List<String> likedByList = [];
  //   try {
  //     likedByList = List<String>.from(json.decode(likedByJson));
  //   } catch (e) {
  //     likedByList = [];
  //   }
  //
  //   // Check if the current user has already liked the comment
  //   bool isLiked = likedByList.contains(currentUserId);
  //
  //   // Toggle like/unlike action
  //   if (isLiked) {
  //     likedByList.remove(currentUserId); // Remove from liked
  //     final current = commentLikesCount[commentId]?.value ?? 1;
  //     commentLikesCount[commentId]?.value = (current - 1).clamp(0, double.infinity).toInt();
  //   } else {
  //     likedByList.add(currentUserId); // Add to liked
  //     commentLikesCount[commentId]?.value = (commentLikesCount[commentId]?.value ?? 0) + 1;
  //   }
  //
  //   // Update like state and save it
  //   commentLikeStates[commentId]?.value = !isLiked;
  //
  //   // Here you can call the API to update the backend if necessary
  //   // For example:
  //   likeComment(CommentListModel(
  //     comment_id: commentId,
  //       userId: currentUserId,
  //       action: isLiked ? 'unlike' : 'like'
  //   ));
  // }
  //
  // RxInt getLikesCount(int? commentId, int initialCount) {
  //   commentLikesCount.putIfAbsent(commentId!, () => RxInt(initialCount));
  //   return commentLikesCount[commentId]!;
  // }
  //
  // RxBool getLikeState(int? commentId) {
  //   if (!commentLikeStates.containsKey(commentId)) {
  //     commentLikeStates[commentId!] = RxBool(false); // Initialize it if not found
  //   }
  //   return commentLikeStates[commentId]!;
  // }



  @override
  void onInit() {
    super.onInit();
    // getPostLists();
    Future.delayed(Duration(seconds: 10),() {
      getVideoLists();
    });
  }

  Future<void> postLikeApi(PostsListModel postModel) async {
    if (await Utils.hasNetwork()) {
      var response = await apiProvider.likeApi(postModel);

      if (response.success == true && response.data != null) {
        var likedData = response.data as PostsListModel;

        this.postModel.value = likedData;
        this.postModel.refresh();
        getPostLists();
      } else {
        print("Like response has no data.");
      }
    }
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


  Future<void> getCommentsLists(int id) async {
    if (await Utils.hasNetwork()) {
      // Utils.showLoader();
      var response = await apiProvider.getCommentList(id);
      // Utils.hideLoader();
      if (response.success == true) {
        commentList.clear();
        commentList.addAll(response.data! as Iterable<CommentListModel>);
        getPostLists();
      }
      else {
        handleError(response);
      }
    } else {
      Utils.showErrorAlert("Please Check Your Internet Connection");
    }
  }

  Future<void> likeComment(CommentListModel commentListModel) async {
    if(await Utils.hasNetwork()){
      var response = await apiProvider.likeCommentApi(commentListModel);

      print("show like Data ===> ${commentListModel.toJson()}");

      if(response.success==true){

      }
    }
  }


  Future<List<ComReplyModel>> getComReplyLists(int id) async {
    if (await Utils.hasNetwork()) {
      var response = await apiProvider.getReplyList(id);
      if (response.success == true && response.data != null) {
        // Parse each item with fromJson if not already parsed
        return (response.data as List).map((item) {
          if (item is ComReplyModel) {
            return item;
          } else {
            return ComReplyModel.fromJson(item as Map<String, dynamic>);
          }
        }).toList();
      } else {
        handleError(response);
        return [];
      }
    } else {
      Utils.showErrorAlert("Please Check Your Internet Connection");
      return [];
    }
  }

  Future<void> fetchRepliesForAllComments() async {
    for (var comment in commentList) {
      int commentId = comment.id!;
      final replies = await getComReplyLists(commentId);
      print("Replies for comment $commentId: ${replies.length}"); // 👈 debug
      replyMap[commentId] = replies;
    }
  }

  Future<void> commentPostApi(CommentModel commentModel) async {
    if(await Utils.hasNetwork()){
      var response = await apiProvider.uploadCommentApi(commentModel);
      if(response.success = true){

        getPostLists();
      }else{
        handleError(response);
      }
    }
  }


  Future<void> replyPostApi(ComReplyModel replyModel) async {
    if(await Utils.hasNetwork()){
      var response = await apiProvider.replyComApi(replyModel);
      if(response.success = true){

        // getPostLists();
      }else{
        handleError(response);
      }
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