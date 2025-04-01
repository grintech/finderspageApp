import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:projects/data/models/signupModel.dart';

import '../../utils/shared/dataResponse.dart';
import '../Injector.dart';
import '../apiConstants.dart';
import '../models/mainHomeModel.dart';
import '../models/userModel.dart';

class AuthApiProvider {
  late Dio _dio;

  AuthApiProvider() {
    _dio = Injector().getDio();
  }

  Future<dynamic> signIn(UserModel userModel) async {
    try {
      Response response = await _dio.post(ApiConstants.loginApi, data: userModel);
      var dataResponse = DataResponse<UserModel>.fromJson(response.data,
              (data) => UserModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      return DataResponse(message: error.toString());
    }
  }

  Future<dynamic> signUp(UserModel userModel) async {
    try {
      Response response = await _dio.post(ApiConstants.signupApi,
          data: userModel);
      var dataResponse = DataResponse<UserModel>.fromJson(
          response.data, (data) => UserModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      return DataResponse(message: error.toString());
    }
  }

  Future<dynamic> forgot(UserModel userModel) async {
    try {
      Response response = await _dio.post(ApiConstants.forgotApi, data: userModel);
      var dataResponse = DataResponse<UserModel>.fromJson(response.data, (data) => UserModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      return DataResponse(message: error.toString());
    }
  }


}