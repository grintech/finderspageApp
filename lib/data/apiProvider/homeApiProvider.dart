import 'package:dio/dio.dart';
import 'package:projects/data/models/shopDetailModel.dart';
import 'package:projects/data/models/shopModel.dart';

import '../../utils/shared/dataResponse.dart';
import '../../utils/shared/pageResponse.dart';
import '../Injector.dart';
import '../apiConstants.dart';
import '../models/userModel.dart';

class HomeApiProvider{
  late Dio _dio;

  HomeApiProvider() {
    _dio = Injector().getDio();
  }

  Future<PageResponse> getHomeList() async {
    try {
      Response response = await _dio.get(ApiConstants.homeList, options: Injector.getHeaderToken());
      var dataResponse = PageResponse<UserModel>.fromJson(response.data, (data) => UserModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
      return PageResponse(message: error.toString());
    }
  }

  Future<PageResponse> getShopList() async {
    try {
      Response response = await _dio.get(ApiConstants.shopList, options: Injector.getHeaderToken());
      var dataResponse = PageResponse<ShopModel>.fromJson(response.data, (data) => ShopModel.fromJson(data as Map<String, dynamic>));
      return dataResponse;
    } catch (error) {
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

      var dataResponse = DataResponse<ShopDetailModel>.fromJson(response.data, (data) => ShopDetailModel.fromJson(data as Map<String, dynamic>),
      );

      print("Parsed DataResponse: ${dataResponse.toJson}");

      return dataResponse;
    } catch (error) {
      print("API Error: $error");
      return DataResponse(error: "$error");
    }
  }

}