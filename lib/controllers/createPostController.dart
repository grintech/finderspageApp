import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostController extends GetxController {
  var selectedImagePath = ''.obs;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      selectedImagePath.value = image.path;
    }
    // else {
    //   Get.snackbar("Error", "No image selected",
    //       snackPosition: SnackPosition.BOTTOM);
    // }
  }
}