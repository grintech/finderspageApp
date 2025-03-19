// import 'dart:io';
// import 'dart:ui';
//
//
// import 'package:crop_image/crop_image.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:projects/utils/colorConstants.dart';
// import 'package:projects/utils/util.dart';
//
//
// class CropperScreen extends StatefulWidget {
//
//   late String file;
//   double aspectRatio = 1 / 1;
//
//   CropperScreen({Key? key, required this.file, required this.aspectRatio}) : super(key: key);
//
//   @override
//   State<CropperScreen> createState() => _CropperScreenState();
// }
//
// class _CropperScreenState extends State<CropperScreen> {
//
//   final controller = CropController(
//     aspectRatio: 1,
//     defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 60,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Theme.of(context).dividerColor.withOpacity(.25),
//                   blurRadius: 10.0,
//                 ),
//               ],
//             ),
//             child: Stack(
//               children: [
//                 GestureDetector(
//                   onTap: (){
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     alignment: Alignment.centerLeft,
//                     child: const Icon(Icons.arrow_back_ios_rounded, size: 22, color: blackColor),
//                   ),
//                 ),
//                 const Center(
//                   child: Text(
//                     "",
//                     style: TextStyle(color: blackColor, fontSize: 18, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     _cropImage(context);
//                   } ,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     alignment: Alignment.centerRight,
//                     child: const Icon(Icons.check, size: 26, color: blackColor,),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: CropImage(
//               controller: controller,
//               image: Image.file(File(widget.file)),
//               gridColor: Colors.white,
//               gridCornerSize: 50,
//               gridThinWidth: 1,
//               gridThickWidth: 3,
//               scrimColor: Colors.black38,
//               alwaysShowThirdLines: true,
//               onCrop: (rect) => debugPrint(rect.toString()),
//               minimumImageSize: 50,
//             ),
//             // child: Crop.file(
//             //   File(widget.file),
//             //   key: cropKey,
//             //   aspectRatio: widget.aspectRatio,
//             //   alwaysShowGrid: true,
//             // ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _cropImage(BuildContext context) async {
//     // return;
//     // final scale = cropKey.currentState?.scale;
//     // final area = cropKey.currentState?.area;
//     // if (area == null || scale == null) {
//     //   // cannot crop, widget is not setup
//     //   return;
//     // }
//
//     // if (!(await hasStorageEnabled())) {
//     //   showLog("Storage permission is not enabled");
//     //   return;
//     // }
//     var bitmap = await controller.croppedBitmap();
//     var data = await bitmap.toByteData(format: ImageByteFormat.png);
//     var bytes = data!.buffer.asUint8List();
//     Directory tempDir = await getTemporaryDirectory();
//     String filePath = "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png";
//     debugPrint("new file path $filePath");
//     var file = File(filePath);
//     debugPrint("created file path ${file.path}");
//     file.writeAsBytes(bytes,flush: true);
//     debugPrint("file successfully saved");
//     Navigator.pop(context, file);
//
//     //   // _cropImage(context);
//     //
//     //   // scale up to use maximum possible number of pixels
//     //   // this will sample image in higher resolution to make cropped image larger
//     //   final sample = await ImageCrop.sampleImage(
//     //     file: File(widget.file),
//     //     preferredSize: 1024,
//     //   );
//     //
//     //   // final file = await ImageCrop.cropImage(file: File(widget.file), area: area);
//     //   final file = await ImageCrop.cropImage(file: sample, area: area);
//     //   sample.delete();
//     //   Navigator.pop(context, file);
//     //   debugPrint('$file');
//     // } else {
//     //   debugPrint('Storage permission denied');
//     // }
//   }
//
//   Future<bool> hasStorageEnabled() async {
//     // return true;
//     PermissionStatus status;
//     if (Platform.isAndroid) {
//       status = await Permission.storage.request();
//     } else {
//       status = await Permission.photos.request();
//     }
//     debugPrint("status: " + status.toString());
//     if (Platform.isAndroid) {
//       if (status == PermissionStatus.permanentlyDenied) {
//         Utils.error("Storage permission permanently denied, we are redirecting to you setting screen to enable permission");
//         Future.delayed(const Duration(seconds: 4), () {
//           openAppSettings();
//         });
//         return false;
//       } else if (status == PermissionStatus.granted) {
//         return true;
//       } else {
//         Utils.error("Storage permission denied, please allow permission to crop photo");
//         return false;
//       }
//     } else {
//       if (status == PermissionStatus.permanentlyDenied) {
//         Utils.error("Photos permission permanently denied, we are redirecting to you setting screen to enable permission");
//         Future.delayed(const Duration(seconds: 4), () {
//           openAppSettings();
//         });
//         return false;
//       } else if (status == PermissionStatus.granted || status == PermissionStatus.limited) {
//         return true;
//       } else {
//         Utils.error("Storage permission denied, please allow permission to crop photo");
//         return false;
//       }
//     }
//   }
// }
