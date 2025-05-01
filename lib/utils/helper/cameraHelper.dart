import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/utils/helper/trimmerView.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../cropperScreen.dart';


abstract class CameraOnCompleteListener {

  void onSuccessFile(String selectedUrl, String fileType);

  void onSuccessVideo(String selectedUrl, Uint8List? thumbnail);

}

class CameraHelper {

  final picker = ImagePicker();

  BuildContext context = Get.context!;
  late CameraOnCompleteListener callback;

  CameraHelper(this.callback);

  bool isCropping = true;
  double aspectRatio = 1 / 1;

  // void openAttachmentDialog() async {
  //   if (await isStorageEnabled()) {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: [
  //         'pdf',
  //         'docx',
  //         'xlsx',
  //         'pptx',
  //         'doc',
  //         'xls',
  //         'ppt',
  //         'txt'
  //       ],
  //     );
  //
  //     if (result != null) {
  //       File file = File(result.files.single.path!);
  //       debugPrint(file.path);
  //       callback.onSuccessFile(file, "document");
  //     } else {
  //       // User canceled the picker
  //     }
  //   }
  // }

  //for picking image from camera and gallery 1 => camera and 2 => gallery
  void openImageVideoPicker({int type = 1}) {
    showDialog(
      context: context,
      useRootNavigator: false, builder: (BuildContext context) {

        return AlertDialog(
          content: Container(
            height: 200,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.3, 1.0], // 30% and 100%
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x194A841C),
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 19,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          type == 1?Text(
                            "Camera",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ):Text(
                            "Video",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        if (type == 1) {
                          getImage(ImageSource.camera);
                        } else {
                          getVideo(ImageSource.camera);
                        }
                      },
                    ),
                    const SizedBox(width: 60),
                    GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.3, 1.0], // 30% and 100%
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x194A841C),
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 19,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.image_rounded,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Gallery",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        if (type == 1) {
                          getImage(ImageSource.gallery);
                        } else {
                          getVideo(ImageSource.gallery);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  onTap: () => Get.back(),
                )
              ],
            ),
          ),
        );
    },
      // backgroundColor: Colors.transparent,
    );
  }

  Future getImage(ImageSource imageSource) async {
    XFile? imageFile = await picker.pickImage(source: imageSource, imageQuality: 60);
    if (isCropping == false) {
      if (imageFile != null) {
        callback.onSuccessFile(imageFile.path, "image");
      } else {
        debugPrint('No image selected.');
      }
      return;
    }
    File? croppedFile;
    if (imageFile != null) {
      croppedFile = await Get.to(() => CropperScreen(file: imageFile.path, aspectRatio: aspectRatio,));
    }
    if (croppedFile != null) {
      debugPrint("Selected image => ${croppedFile.path}");
      callback.onSuccessFile(croppedFile.path, "image");
    } else {
      debugPrint('No image selected.');
    }
  }

  Future getVideo(ImageSource source, {isTrimming = true}) async {
    XFile? imageFile = await picker.pickVideo(source: source, maxDuration: const Duration(seconds: 10));
    if (imageFile != null) {
      debugPrint("Selected video => ${imageFile.path}");
      String? result;
      // if (isTrimming) {
      //   result = await Get.to((TrimmerView(file: File(imageFile.path))));
      // } else {
      //   result = imageFile.path;
      // }
      debugPrint("pickVideoGallery $result");
      if (result != null) {
        final uint8list = await VideoThumbnail.thumbnailData(
          video: result,
          imageFormat: ImageFormat.PNG,
          maxWidth: 256, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
          quality: 60,
        );
        debugPrint("thumbnail $uint8list");
        callback.onSuccessVideo(result, uint8list);
      }
    } else {
      debugPrint('No video selected.');
    }
  }
}
enum ImageType { profile, cover }