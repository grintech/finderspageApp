import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:projects/data/models/videoUploadModel.dart';
import 'package:projects/utils/shared/dataResponse.dart';
import 'package:path/path.dart' as path;
import '../../utils/util.dart';
import '../Injector.dart';
import '../apiConstants.dart';

class CreatePostApiProvider{
  late Dio _dio;

  CreatePostApiProvider() {
    _dio = Injector().getDio();
  }

  Future<DataResponse> uploadVideoApp(VideoUploadModel videoUploadModel)
  async {
    try {
      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('title', videoUploadModel.title ?? ""),
        MapEntry('location', videoUploadModel.location ?? ''),
        MapEntry('sub_category', videoUploadModel.subCategory ?? ''),
        MapEntry('description', videoUploadModel.description ?? ''),
        MapEntry('user_id', videoUploadModel.id.toString()),
        MapEntry('type', videoUploadModel.type ?? ''),
      ]);

      if (videoUploadModel.postVideo != null && videoUploadModel.postVideo!.isNotEmpty) {
        final file = File(videoUploadModel.postVideo!);
        if (await file.exists()) {
          formData.files.add(MapEntry(
            'post_video',
            await MultipartFile.fromFile(file.path, filename: path.basename(file.path)),
          ));
        }
      }

      if (videoUploadModel.image1 != null && videoUploadModel.image1!.isNotEmpty) {
        final file = File(videoUploadModel.image1!);
        if (await file.exists()) {
          formData.files.add(MapEntry(
            'image1',
            await MultipartFile.fromFile(file.path, filename: path.basename(file.path)),
          ));
        }
      }

      // Send request
      Response response = await _dio.post(ApiConstants.uploadVideo, data: formData, options: Injector.getHeaderToken(),);

      var dataResponse = DataResponse<VideoUploadModel>.fromJson(response.data, (data) => VideoUploadModel.fromJson(data as Map<String, dynamic>),
      );
      return dataResponse;

    } catch (error) {
      return DataResponse(message: error.toString());
    }
  }

  Future<DataResponse> uploadPostApp(VideoUploadModel videoUploadModel)
  async {
    try {
      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('description', videoUploadModel.description ?? ""),
        MapEntry('location', videoUploadModel.location ?? ''),
        MapEntry('shares', videoUploadModel.shares.toString()),
        MapEntry('comment_option', videoUploadModel.commentOption.toString()),
        MapEntry('likes_btn', videoUploadModel.likesBtn ?? ''),
        MapEntry('categories', videoUploadModel.categories ?? ''),
        MapEntry('user_id', videoUploadModel.id.toString()),
        MapEntry('type', videoUploadModel.type ?? ''),
      ]);

      if (videoUploadModel.image1 != null && videoUploadModel.image1!.isNotEmpty) {
        final file = File(videoUploadModel.image1!);
        if (await file.exists()) {
          formData.files.add(MapEntry(
            'image1',
            await MultipartFile.fromFile(file.path, filename: path.basename(file.path)),
          ));
        }
      }

      // Send request
      Response response = await _dio.post(ApiConstants.createPost, data: formData, options: Injector.getHeaderToken(),);

      var dataResponse = DataResponse<VideoUploadModel>.fromJson(response.data, (data) => VideoUploadModel.fromJson(data as Map<String, dynamic>),
      );
      return dataResponse;

    } catch (error) {
      return DataResponse(message: error.toString());
    }
  }


}