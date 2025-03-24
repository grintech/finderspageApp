import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:projects/utils/helper/storageHelper.dart';

import '../utils/util.dart';

class Injector {

  static final Injector _singleton = Injector._internal();
  static final _dio = Dio();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  Dio getDio(){
    BaseOptions options =
    BaseOptions(receiveTimeout: Duration(milliseconds: 180000), connectTimeout: Duration(milliseconds: 180000));
    _dio.options = options;
    _dio.options.followRedirects = false;
    _dio.options.headers["Content-Type"] = "application/json";
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _dio.interceptors.clear();
    _dio.interceptors.add(LoggingInterceptors());
    return _dio;
  }

  static Options? getHeaderToken(){
    String? token = StorageHelper().getUserToken();
    if (token != null) {
      Utils.showLog("token => " + token);
      // int? userId = StorageHelper().getUserId();
      // if (userId != null) {
      //   Utils.showLog("userId =>" + userId.toString());
      // }
      var headerOptions = Options(headers: {'x-access-token': token,});
      return headerOptions;
    }
    return null;
  }
}

class LoggingInterceptors extends Interceptor {

  String showLogObject(Object object) {
    // Encode your object and then decode your object to Map variable
    Map jsonMapped = json.decode(json.encode(object));
    // Using JsonEncoder for spacing
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    // encode it to string
    String prettyPrint = encoder.convert(jsonMapped);
    return prettyPrint;
  }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Utils.showLog("--> ${options.method.toUpperCase()} ${"" + (options.baseUrl) + (options.path)}");
    Utils.showLog("Headers:");
    options.headers.forEach((k, v) => Utils.showLog('$k: $v'));
    Utils.showLog("queryParameters:");
    options.queryParameters.forEach((k, v) => Utils.showLog('$k: $v'));
    if (options.data != null) {
      try{
        // showLog("Body: ${showLogObject(options.data)}");
        FormData formData = options.data as FormData;
        Utils.showLog("Body:");
        var buffer = [];
        for(MapEntry<String, String> pair in formData.fields){
          buffer.add(pair.key+ ':' + pair.value);
        }
        Utils.showLog("Body:{${buffer.join(', ')}}");
      }catch(e){
        Utils.showLog("Body: ${showLogObject(options.data)}");
      }
    }
    Utils.showLog("--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    showLogObject("<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL')}");
    Utils.showLog("${dioError.response != null ? dioError.response!.data : 'Unknown Error'}");
    Utils.showLog("<-- End error");
    // switch(dioError.response?.statusCode) {
    //   case 400:
    //     MyApp.startFirstScreen("User not found. Please log-in or create an account.");
    //     break;
    //   case 401:
    //     MyApp.startFirstScreen("Your account is deleted from admin. Please contact at ubsold@gmail.com");
    //     break;
    //   case 402:
    //     MyApp.startFirstScreen("Your account is inactive from admin. Please contact at ubsold@gmail.com");
    //     break;
    //   case 403:
    //     MyApp.startFirstScreen("Session expire. Please log-in again.");
    //     break;
    //   case 405:
    //     MyApp.startFirstScreen("Your account is block from admin. Please contact at ubsold@gmail.com");
    //     break;
    // }
    return super.onError(dioError, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Utils.showLog("<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
    Utils.showLog("Headers:");
    response.headers.forEach((k, v) => Utils.showLog('$k: $v'));
    Utils.showLog("Response: ${response.data}");
    Utils.showLog("<-- END HTTP");
    return super.onResponse(response, handler);
  }
}
