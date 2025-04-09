import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:projects/data/models/videoUploadModel.dart';
import 'package:projects/utils/shared/dataResponse.dart';

import '../../utils/util.dart';
import '../Injector.dart';
import '../apiConstants.dart';

class CreatePostApiProvider{
  late Dio _dio;

  CreatePostApiProvider() {
    _dio = Injector().getDio();
  }

  Future<DataResponse> uploadVideoApp({
    required String title,
    required String location,
    required List<File> image1, // This should be a file path
    required String description,
    required List<File> videoFiles,
    required String userId,
    required String subCategory,
  })
  async {
    try {
      // Convert video files to MultipartFile
      List<MultipartFile> multipartVideos = [];
      List<MultipartFile> multipartThumbnail = [];

      for (var file in videoFiles) {
        String fileType = file.path.split(".").last;
        multipartVideos.add(
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split("/").last,
            contentType: MediaType(Utils.getFileType(file.path)!, fileType),
          ),
        );
      }

      for (var file in image1) {
        String fileType = file.path.split(".").last;
        multipartThumbnail.add(
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split("/").last,
            contentType: MediaType(Utils.getFileType(file.path)!, fileType),
          ),
        );
      }

      print("Uploading files:");
      print("Image1 path: $image1");
      print("Video files: ${videoFiles.map((e) => e.path).toList()}");

      // Create FormData
      FormData formData = FormData.fromMap({
        "title": title,
        "location": location,
        "image1[]": multipartThumbnail,
        "description": description,
        "user_id": userId,
        "sub_category": subCategory,
        "post_video[]": multipartVideos,
      });

      // Send request
      Response response = await _dio.post(ApiConstants.uploadVideo,
        data: formData, options: Injector.getHeaderToken(),);

      var dataResponse = DataResponse<VideoUploadModel>.fromJson(response.data, (data) => VideoUploadModel.fromJson(data as Map<String, dynamic>),
      );
      return dataResponse;

    } catch (error) {
      return DataResponse(message: error.toString());
    }
  }


}