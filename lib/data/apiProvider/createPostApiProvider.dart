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

  Future<DataResponse> uploadVideoApp(VideoUploadModel videoUploadModel) async {
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
      final res = (error as dynamic).response;
      if (res != null) return DataResponse.fromJson(res?.data, (data) => null);
      return DataResponse(message: error.toString());
    }
  }

  Future<DataResponse> uploadPostApp(VideoUploadModel videoUploadModel) async {
    try {
      FormData formData = FormData();

      // Add text fields
      formData.fields.addAll([
        MapEntry('description', videoUploadModel.description ?? ""),
        MapEntry('location', videoUploadModel.location ?? ''),
        MapEntry('shares', videoUploadModel.shares.toString()),
        MapEntry('comment_option', videoUploadModel.commentOption.toString()),
        MapEntry('likes_btn', videoUploadModel.likesBtn ?? ''),
        MapEntry('categories', videoUploadModel.categories ?? ''),
        MapEntry('user_id', videoUploadModel.id.toString()),
        MapEntry('type', videoUploadModel.type ?? ''),
        MapEntry('donation_link', videoUploadModel.donationLink ?? ''),
        MapEntry('image1', videoUploadModel.image1 ?? '[]'), // JSON string of filenames
      ]);

      // Add media files
      if (videoUploadModel.selectedFiles != null &&
          videoUploadModel.selectedFiles!.isNotEmpty) {
        for (File file in videoUploadModel.selectedFiles!) {
          if (await file.exists()) {
            formData.files.add(MapEntry(
              'image1[]', // Use same key for all files
              await MultipartFile.fromFile(
                file.path,
                filename: path.basename(file.path),
              ),
            ));
          }
        }
      }

      // Debug log
      print("📝 FormData Fields:");
      formData.fields.forEach((e) => print('${e.key}: ${e.value}'));
      print("📦 FormData Files:");
      formData.files.forEach((f) => print('${f.key}: ${f.value.filename}'));

      // Send request
      Response response = await _dio.post(ApiConstants.createPost, data: formData, options: Injector.getHeaderToken(),
      );

      return DataResponse<VideoUploadModel>.fromJson(
        response.data,
            (data) => VideoUploadModel.fromJson(data as Map<String, dynamic>),
      );
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) {
        return DataResponse.fromJson(res.data, (data) => null);
      }
      return DataResponse(message: error.toString());
    }
  }


  Future<DataResponse> editPost(VideoUploadModel videoUploadModel, int id) async {
    try {
      FormData formData = FormData();

      // Add text fields
      formData.fields.addAll([
        MapEntry('description', videoUploadModel.description ?? ""),
        MapEntry('location', videoUploadModel.location ?? ''),
        MapEntry('shares', videoUploadModel.shares.toString()),
        MapEntry('comment_option', videoUploadModel.commentOption.toString()),
        MapEntry('likes_btn', videoUploadModel.likesBtn ?? ''),
        MapEntry('categories', videoUploadModel.categories ?? ''),
        MapEntry('user_id', videoUploadModel.id.toString()),
        MapEntry('type', videoUploadModel.type ?? ''),
        MapEntry('donation_link', videoUploadModel.donationLink ?? ''),
        MapEntry('image1', videoUploadModel.image1 ?? '[]'), // JSON string of filenames
      ]);

      // Add media files
      if (videoUploadModel.selectedFiles != null &&
          videoUploadModel.selectedFiles!.isNotEmpty) {
        for (File file in videoUploadModel.selectedFiles!) {
          if (await file.exists()) {
            formData.files.add(MapEntry(
              'image1[]', // Use same key for all files
              await MultipartFile.fromFile(
                file.path,
                filename: path.basename(file.path),
              ),
            ));
          }
        }
      }

      // Debug log
      print("📝 FormData Fields:");
      formData.fields.forEach((e) => print('${e.key}: ${e.value}'));
      print("📦 FormData Files:");
      formData.files.forEach((f) => print('${f.key}: ${f.value.filename}'));

      // Send request
      Response response = await _dio.post("${ApiConstants.updatePost}/$id", data: formData, options: Injector.getHeaderToken(),
      );

      return DataResponse<VideoUploadModel>.fromJson(response.data, (data) => VideoUploadModel.fromJson(data as Map<String, dynamic>),);
    } catch (error) {
      final res = (error as dynamic).response;
      if (res != null) {
        return DataResponse.fromJson(res.data, (data) => null);
      }
      return DataResponse(message: error.toString());
    }
  }

}