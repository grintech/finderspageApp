import 'dart:convert';
import 'dart:ffi';

import 'package:get_storage/get_storage.dart';

import '../../data/models/mainHomeModel.dart';
import '../../data/models/userModel.dart';

class StorageHelper{

  static late GetStorage getStorage;

  static const String _userType = "userType";
  static const String _userId = "userId";
  static const String _userToken = "userToken";
  static const String _userModel = "userModel";

  static const JsonDecoder _decoder = JsonDecoder();
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  static Future<GetStorage?> init() async {
    await GetStorage.init("FindersPage");
    getStorage = GetStorage("FindersPage");
    return getStorage;
  }

  _savePref(String key, Object? value) async {
    var prefs = getStorage;
    if (prefs.hasData(key)) {
      prefs.remove(key);
    }
    if (value is bool) {
      return prefs.write(key, value);
    } else if (value is int) {
      return prefs.write(key, value);
    } else if (value is String) {
      return prefs.write(key, value);
    } else if (value is Double || value is Float) {
      return prefs.write(key, value as double);
    }
  }

  T _getPref<T>(String key) {
    return getStorage.read(key) as T;
  }


  void clearAll() {
    getStorage.erase();
  }

  String? getUserType() {
    return _getPref(_userType);
  }

  void saveUserType(String? value) {
    _savePref(_userType, value);
  }

  UserModel? getUserModel() {
    String? user = _getPref(_userModel);
    if (user != null) {
      Map<String, dynamic>  userMap = _decoder.convert(user);
      return UserModel.fromJson(userMap);
    } else {
      return null;
    }
  }
  void saveUserModel(UserModel? userModel) {
    if (userModel != null) {
      String value = _encoder.convert(userModel);
      _savePref(_userModel, value);
    } else {
      _savePref(_userModel, null);
    }
  }

  String? getUserToken() {
    return _getPref(_userToken);
  }

  void saveUserToken(String? token) {
    _savePref(_userToken, token);
  }
}