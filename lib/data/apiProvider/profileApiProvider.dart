import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:path/path.dart' as path;
import '../../utils/shared/dataResponse.dart';
import '../Injector.dart';
import '../apiConstants.dart';
import '../models/userModel.dart';

class ProfileApiProvider{
  late Dio _dio;

  ProfileApiProvider() {
    _dio = Injector().getDio();
  }

  Future<dynamic> getUserApi() async {
    try {
      Response response = await _dio.get("${ApiConstants.getUser}/${StorageHelper().getUserModel()?.user?.id}",
          options: Injector.getHeaderToken());
      var dataResponse = DataResponse<UserModel>.
      fromJson(response.data, (data) => UserModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      return DataResponse(message:error.toString());
    }
  }

  Future<dynamic> updateProfileApi(UserModel userModel) async {
    try {
      FormData formData = FormData();

      // Add fields
      formData.fields.addAll([
        MapEntry('id', userModel.id.toString()),
        MapEntry('first_name', userModel.first_name ?? ''),
        MapEntry('username', userModel.username ?? ''),
        MapEntry('bio', userModel.bio ?? ''),
        MapEntry('zipcode', userModel.zipcode ?? ''),
        MapEntry('address', userModel.address ?? ''),
        MapEntry('phonenumber', userModel.phonenumber ?? ''),
        // MapEntry(
        //   'dob', userModel.dob != null ? DateFormat('yyyy-MM-dd').format(userModel.dob!) : '',
        // ),
        MapEntry('profession', userModel.profession ?? ''),
      ]);

      // Add image file only if it exists
      if (userModel.image != null && userModel.image!.isNotEmpty) {
        final file = File(userModel.image!);
        if (await file.exists()) {
          formData.files.add(MapEntry(
            'image',
            await MultipartFile.fromFile(file.path, filename: path.basename(file.path)),
          ));
        }
      }

      if (userModel.cover_img != null && userModel.cover_img!.isNotEmpty) {
        final file = File(userModel.cover_img!);
        if (await file.exists()) {
          formData.files.add(MapEntry(
            'cover_img',
            await MultipartFile.fromFile(file.path, filename: path.basename(file.path)),
          ));
        }
      }

      // Send POST request with FormData
      Response response = await _dio.post(ApiConstants.updateUser, options: Injector.getHeaderToken(), data: formData,);

      var dataResponse = DataResponse<UserModel>.fromJson(
        response.data,
            (data) => UserModel.fromJson(data as Map<String, dynamic>),
      );

      return dataResponse;
    } catch (error) {
      return DataResponse(message: error.toString());
    }
  }


  Future<dynamic> logOut() async {
    try {
      Response response = await _dio.post(ApiConstants.logOutApi, options: Injector.getHeaderToken());
      var dataResponse = DataResponse<UserModel>.
      fromJson(response.data, (data) => UserModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      return DataResponse(message:error.toString());
    }
  }
}