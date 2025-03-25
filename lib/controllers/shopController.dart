import 'package:get/get.dart';
import 'package:projects/data/models/shopDetailModel.dart';

import '../data/apiProvider/homeApiProvider.dart';
import '../data/models/shopModel.dart';
import '../utils/util.dart';

class ShopController extends GetxController{

  late HomeApiProvider apiProvider;
  RxList<ShopModel> shopList=RxList();
  Rx<ShopDetailModel> shopDetailModel = ShopDetailModel().obs;


  @override
  void onInit() {
    apiProvider = HomeApiProvider();
    getShopListApi();
    super.onInit();
  }

  Future<void> getShopListApi() async {
    if (await Utils.hasNetwork()) {
      // Utils.showLoader();
      var response = await apiProvider.getShopList();
      // Utils.hideLoader();
      if (response.success == true) {
        shopList.addAll(response.data! as Iterable<ShopModel>);
      }
      else {
        handleError(response);
      }
    } else {
      // Utils.showErrorAlert("Please Check Your Internet Connection");
    }
  }

  Future<void> getShopDetailApi(String slug) async {
    if (await Utils.hasNetwork()) {
      // Utils.showLoader();
      var response = await apiProvider.getShopDetail(slug);

      print("API Response: $response"); // Debugging step

      // Utils.hideLoader();
      if (response != null) {
        if (response.success == true && response.data != null) {
          shopDetailModel.value = response.data!;
          print("Updated ShopDetailModel: ${shopDetailModel.value.toJson()}"); // Debugging
        } else {
          handleError(response);
        }
      } else {
        print("Error: API response is null");
      }
    }
  }


  void handleError(dynamic response) {
    if (response.message != null) {
      // Utils.showErrorAlert(response.message);
    } else if (response.error != null) {
      // Utils.showErrorAlert(response.error);
    } else {
      // Utils.showErrorAlert("Server Error. Please Try Again");
    }
  }
}