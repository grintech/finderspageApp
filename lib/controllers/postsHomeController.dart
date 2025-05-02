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
import 'package:projects/data/models/notificationModel.dart';
import 'package:projects/utils/shared/dataResponse.dart';
import 'package:video_player/video_player.dart';
import '../data/apiConstants.dart';
import '../data/models/userModel.dart';
import '../utils/helper/storageHelper.dart';
import '../utils/routes.dart';
import '../utils/util.dart';

class PostsHomeController extends GetxController{
  var tabIndex = 0.obs;

  late TabController tabController;
  var userModel = Rxn<UserModel>();

  HomeApiProvider apiProvider = HomeApiProvider();
  RxList<PostsListModel> postsList=RxList();
  RxList<PostsListModel> videoList=RxList();
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  RxList<CommentListModel> commentList=RxList();
  RxList<ComReplyModel> replyList=RxList();
  RxSet<int> expandedReplies = <int>{}.obs;
  RxList<String> videoUrls = <String>[].obs;


  final List<String> videoLoadingUrls = []; // or your video model
  final Map<int, VideoPlayerController> _videoControllers = {};
  final Map<int, Future<VideoPlayerController>> _initializingControllers = {};
  bool hasLoaded = false;
  // List<VideoPlayerController?> get videoLoadingList => _videoControllers;



  var hasMoreData = true.obs;


  final ScrollController scrollController = ScrollController();

  final Map<int, VideoPlayerController> videoControllers = {};
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

  @override
  void onInit()async{
    super.onInit();
    // Future.delayed(Duration(seconds: 2), (){
     await getVideoLists();
    userModel.value = StorageHelper().getUserModel();
    // });
    getPostLists();
    // setupScrollListener();
  }

  Future<void> loadVideosOnce() async {
    if (hasLoaded) return;
    await getVideoLists();
    hasLoaded = true;
    update();
  }

  Future<VideoPlayerController> getController(int index) {
    final url = videoUrls[index];

    // Already initialized
    if (_videoControllers.containsKey(index)) {
      return Future.value(_videoControllers[index]!);
    }

    // Already initializing
    if (_initializingControllers.containsKey(index)) {
      return _initializingControllers[index]!;
    }

    final controller = VideoPlayerController.network(url);
    final initializing = controller.initialize().then((_) {
      controller.setLooping(true);
      _videoControllers[index] = controller;
      return controller;
    }).catchError((error) {
      print('Video init failed at $url: $error');
      throw error;
    });

    _initializingControllers[index] = initializing;
    return initializing;
  }


  void preloadNext(int index) {
    final next = index + 1;
    if (next < videoList.length && !_videoControllers.containsKey(next)) {
      getController(next); // triggers preload
    }
  }

  String _getFirstVideoUrl(PostsListModel post) {
    try {
      final List<String> videos = List<String>.from(jsonDecode(post.postVideo));
      return videos.isNotEmpty ? "${ApiConstants.postImgUrl}/${videos.first}" : "";
    } catch (e) {
      return "";
    }
  }

  // VideoPlayerController? getController(int index) => videoControllers[index];

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

  Future<void> deletePostApi(int id) async {
    if (await Utils.hasNetwork()) {
      var response = await apiProvider.deletePost(id);

      if (response.success == true) {
        Utils.error(response.message);
        getPostLists();
      } else {
        print("Like response has no data.");
      }
    }
  }

  Future<void> videoLikeApi(PostsListModel postModel) async {
    if (await Utils.hasNetwork()) {
      var response = await apiProvider.likeApi(postModel);


      if (response.success == true && response.data != null) {
        var likedData = response.data as PostsListModel;

        this.postModel.value = likedData;
        this.postModel.refresh();
        getVideoLists();
        commentList.refresh();
      } else {
        print("Like response has no data.");
      }
    }
  }

  Future<void> getPostLists() async {
    if (await Utils.hasNetwork()) {
      // Map<String, dynamic> queries = HashMap();
      // //queries['filter'] = 'inReview';
      // queries['page'] = 1;
      // queries['per_page'] = 20;
      // Utils.showLoader();
      var response = await apiProvider.getAllPostList();
      // Utils.hideLoader();
      if (response.success == true && response.data != null) {
        postsList.clear();
        postsList.addAll(response.data! as Iterable<PostsListModel>);
        getVideoLists();
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

  // Future<void> getVideoLists() async {
  //   if (await Utils.hasNetwork()) {
  //     var response = await apiProvider.getAllVideoList();
  //     if (response.success == true) {
  //       videoList.clear();
  //       videoList.addAll(response.data! as Iterable<PostsListModel>);
  //       extractFirstVideoUrls();
  //       update(); // <- necessary to rebuild the UI
  //     } else {
  //       handleError(response);
  //     }
  //   } else {
  //     Utils.showErrorAlert("Please Check Your Internet Connection");
  //   }
  // }



  Future<void>  getCommentsLists(int id) async {
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

  Future<void> getDeleteComment(int id) async {
    if (await Utils.hasNetwork()) {
      var response = await apiProvider.deleteComment(id);
      if (response.success == true && response.data != null) {
        // await getCommentsLists(postId);
      } else {
        Utils.error(response.message);
      }
    } else {
      Utils.showErrorAlert("Please Check Your Internet Connection");
    }
  }

  Future<void> getDeleteVideoComment(int id, int postId) async {
    if (await Utils.hasNetwork()) {
      var response = await apiProvider.deleteComment(id);
      if (response.success == true && response.data != null) {
        Future.delayed(Duration(seconds: 1),(){
          getVideoLists();
        });
      } else {
        Utils.error(response.message);
      }
    } else {
      Utils.showErrorAlert("Please Check Your Internet Connection");
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
        Future.delayed(Duration(seconds: 1),(){
          getPostLists();
        });
        Future.delayed(Duration(seconds: 2),(){
          getVideoLists();
        });

      }else{
        handleError(response);
      }
    }
  }

  Future<void> commentEditApi(int id, CommentModel commentModel) async {
    if(await Utils.hasNetwork()){
      var response = await apiProvider.editCommentApi(id, commentModel);
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
        Get.back();
        // getPostLists();
      }else{
        handleError(response);
      }
    }
  }

  Future<void> notificationApi(int id)async{
    Map<String, dynamic> queries = HashMap();
    // //queries['filter'] = 'inReview';
    queries['page'] = 1;
    queries['per_page'] = 50;
    if (await Utils.hasNetwork()) {
      var response = await apiProvider.notificationList(id, queries);
      if (response.success == true && response.data != null) {
        notificationList.clear();
        notificationList.addAll(response.data! as Iterable<NotificationModel>);
        Get.toNamed(Routes.notificationRoute);
      } else {
        Utils.error(response.message);
      }
    } else {
      Utils.showErrorAlert("Please Check Your Internet Connection");
    }
  }

  Future<void> clearNotificationApi(int id)async{
    if (await Utils.hasNetwork()) {
      var response = await apiProvider.clearNotificationList(id);
      if (response.success == true && response.data != null) {
        notificationList.clear();
        notificationList.refresh();
      } else {
        Utils.error(response.message);
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
            videoUrls.add("https://www.finderspage.com/public/images_blog_img/${parsed.first}");
          }
        } catch (e) {
          print('Error decoding post_video: $e');
        }
      }
    }
  }

  void updateVideoLike(PostsListModel post, String currentUserId) async {
    Map<String, dynamic> likedByMap = {};
    try {
      if (post.liked_by is String) {
        final likedByString = post.liked_by as String;
        if (likedByString.trim().startsWith('{')) {
          final decoded = json.decode(likedByString);
          if (decoded is Map<String, dynamic>) {
            likedByMap = decoded;
          }
        }
      } else if (post.liked_by is Map) {
        likedByMap = Map<String, dynamic>.from(post.liked_by as Map);
      }
    } catch (_) {}

    final alreadyLiked = likedByMap.containsKey(currentUserId);

    if (alreadyLiked) {
      // Remove like
      likedByMap.remove(currentUserId);
      int currentLikes = (int.tryParse(post.likes ?? '0') ?? 0) - 1;
      post.likes = currentLikes.clamp(0, double.infinity).toInt().toString();
      post.liked_by = likedByMap.map((k, v) => MapEntry(k, v.toString()));

      // Update local list in videoList
      final index = videoList.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        videoList[index] = post;
        videoList.refresh();  // This will notify GetX to update the UI
      }

      // Call unlike API
      await videoLikeApi(PostsListModel(
        user_id: int.parse(currentUserId),
        blog_id: post.id,
        cate_id: 727,
        action: "unlike",
        type: "video",
        url: "https://www.finderspage.com/single-new/${post.slug}",
        reaction: "0",
      ));
    }
  }


  // void extractFirstVideoUrls() {
  //   videoUrls.clear();
  //   for (var post in videoList) {
  //     if (post.postVideo != null && post.postVideo!.isNotEmpty) {
  //       try {
  //         List<dynamic> parsed = json.decode(post.postVideo!);
  //         if (parsed.isNotEmpty) {
  //           videoUrls.add(parsed.first);
  //         }
  //       } catch (e) {
  //         print('Error decoding post_video: $e');
  //       }
  //     }
  //   }
  // }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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

  @override
  void onClose() {
    for (var c in _videoControllers.values) {
      c.dispose();
    }
    super.onClose();
  }
}