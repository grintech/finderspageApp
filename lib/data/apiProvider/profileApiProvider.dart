import 'package:dio/dio.dart';
import 'package:projects/utils/helper/storageHelper.dart';

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