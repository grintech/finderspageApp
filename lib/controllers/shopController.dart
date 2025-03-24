import 'package:get/get.dart';

import '../data/apiProvider/homeApiProvider.dart';

class ShopController extends GetxController{
  late HomeApiProvider apiProvider;


  @override
  void onInit() {
    apiProvider = HomeApiProvider();
    super.onInit();
  }


}