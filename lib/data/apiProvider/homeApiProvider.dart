import 'package:dio/dio.dart';
import 'package:projects/data/models/PostsListModel.dart';
import 'package:projects/data/models/comReplyModel.dart';
import 'package:projects/data/models/commentListModel.dart';
import 'package:projects/data/models/commentModel.dart';
import 'package:projects/data/models/likeModel.dart';
import 'package:projects/data/models/shopDetailModel.dart';
import 'package:projects/data/models/shopModel.dart';

import '../../utils/shared/dataResponse.dart';
import '../../utils/shared/pageResponse.dart';
import '../Injector.dart';
import '../apiConstants.dart';
import '../models/mainHomeModel.dart';

class HomeApiProvider{
  late Dio _dio;

  HomeApiProvider() {
    _dio = Injector().getDio();
  }

  Future<PageResponse> getHomeList() async {
    try {
      Response response = await _dio.get(ApiConstants.homeList, options: Injector.getHeaderToken());
      var dataResponse = PageResponse<MainHomeModel>.fromJson(response.data, (data) => MainHomeModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) return PageResponse.fromJson(res?.data, (data) => null);
      return PageResponse(message: error.toString());
    }
  }

  Future<PageResponse> getShopList() async {
    try {
      Response response = await _dio.get(ApiConstants.shopList, options: Injector.getHeaderToken());
      var dataResponse = PageResponse<ShopModel>.fromJson(response.data, (data) => ShopModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) return PageResponse.fromJson(res?.data, (data) => null);
      return PageResponse(message: error.toString());
    }
  }

  Future<DataResponse> getShopDetail(String slug) async {
    try {
      Response response = await _dio.get(
        '${ApiConstants.shopDetail}/$slug',
        options: Injector.getHeaderToken(),
      );

      print("Raw API Response: ${response.data}");

      var dataResponse = DataResponse<ShopDetailModel>.fromJson(response.data,
            (data) => ShopDetailModel.fromJson(data as Map<String, dynamic>),
      );

      return dataResponse;
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) return DataResponse.fromJson(res?.data, (data) => null);
      return DataResponse(error: error.toString());
    }
  }

  //Post Home Apis
  Future<PageResponse> getAllPostList(Map<String, dynamic>? queries) async {
    try {
      Response response = await _dio.get(ApiConstants.showAllPosts, queryParameters: queries,
          options: Injector.getHeaderToken());
      var dataResponse = PageResponse<PostsListModel>.fromJson(response.data, (data) => PostsListModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) return PageResponse.fromJson(res?.data, (data) => null);
      return PageResponse(message: error.toString());
    }
  }


  Future<PageResponse> getCommentList(int id) async {
    try {
      Response response = await _dio.get("${ApiConstants.commentListApi}/$id",
          options: Injector.getHeaderToken());
      var dataResponse = PageResponse<CommentListModel>.fromJson(response.data, (data) => CommentListModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) return PageResponse.fromJson(res?.data, (data) => null);
      return PageResponse(message: error.toString());
    }
  }


  Future<PageResponse> getReplyList(int id) async {
    try {
      Response response = await _dio.get("${ApiConstants.replyListApi}/$id",
          options: Injector.getHeaderToken());
      var dataResponse = PageResponse<ComReplyModel>.fromJson(
          response.data,
              (data) => ComReplyModel.fromJson(data as Map<String, dynamic>)
      );      return dataResponse;
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) return PageResponse.fromJson(res?.data, (data) => null);
      return PageResponse(message: error.toString());
    }
  }

  Future<DataResponse> uploadCommentApi(CommentModel commentModel) async {
    try {
      Response response = await _dio.post(ApiConstants.commentPostApi, options: Injector.getHeaderToken(), data: commentModel);
      var dataResponse = DataResponse<CommentModel>.fromJson(response.data, (data) => CommentModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) return DataResponse.fromJson(res?.data, (data) => null);
      return DataResponse(message: error.toString());
    }
  }


  Future<DataResponse> replyComApi(ComReplyModel replyModel) async {
    try {
      Response response = await _dio.post(ApiConstants.replyPostApi, options: Injector.getHeaderToken(), data: replyModel);
      var dataResponse = DataResponse<ComReplyModel>.fromJson(response.data, (data) => ComReplyModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) return DataResponse.fromJson(res?.data, (data) => null);
      return DataResponse(message: error.toString());
    }
  }

//Like Post
  Future<DataResponse> likeApi(PostsListModel postModel) async {
    try {
      Response response = await _dio.post(ApiConstants.likeApi, options: Injector.getHeaderToken(), data: postModel);
      var dataResponse = DataResponse<PostsListModel>.fromJson(response.data, (data) => PostsListModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) return DataResponse.fromJson(res?.data, (data) => null);
      return DataResponse(message: error.toString());
    }
  }

//Like Comment
  Future<DataResponse> likeCommentApi(CommentListModel commentListModel) async {
    try {
      Response response = await _dio.post(ApiConstants.commentLikeApi, options: Injector.getHeaderToken(), data: commentListModel);
      var dataResponse = DataResponse<CommentListModel>.fromJson(response.data, (data) => CommentListModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) return DataResponse.fromJson(res?.data, (data) => null);
      return DataResponse(message: error.toString());
    }
  }


  Future<PageResponse> getAllVideoList() async {
    try {
      Response response = await _dio.get(ApiConstants.showAllVideo, options: Injector.getHeaderToken());
      var dataResponse = PageResponse<PostsListModel>.fromJson(response.data, (data) => PostsListModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) return PageResponse.fromJson(res?.data, (data) => null);
      return PageResponse(message: error.toString());
    }
  }

}