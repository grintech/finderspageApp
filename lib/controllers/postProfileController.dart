import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/data/apiProvider/profileApiProvider.dart';
import 'package:projects/utils/helper/storageHelper.dart';
import 'package:projects/utils/routes.dart';
import 'package:projects/utils/shared/dataResponse.dart';

import '../utils/util.dart';

class PostProfileController extends GetxController {

  late ProfileApiProvider _profileApiProvider = ProfileApiProvider();
  late StorageHelper storageHelper = StorageHelper();


  @override
  void onInit() {
    _profileApiProvider = ProfileApiProvider();
    storageHelper = StorageHelper();
    super.onInit();
  }

  Future<void> logOut()async{
    if(await Utils.hasNetwork()){
      Utils.showLoader();
      var res = await _profileApiProvider.logOut();
      Utils.hideLoader();
      var response = res as DataResponse;
      if(response.success==true){
        // storageHelper.clearAll();
        // Get.offAllNamed(Routes.loginRoute);
      }
    }
  }
}