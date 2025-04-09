import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projects/controllers/createPostController.dart';
import 'package:projects/data/models/videoUploadModel.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/util.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

import '../../utils/colorConstants.dart';

class VideoPickerScreen extends StatefulWidget {
  @override
  _VideoPickerScreenState createState() => _VideoPickerScreenState();
}

class _VideoPickerScreenState extends State<VideoPickerScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _videoFile;
  File? imageFile;
  VideoPlayerController? _controller;

  final controller = Get.put(CreatePostController());



  final titleController = TextEditingController();
  final descController = TextEditingController();
  final locController = TextEditingController();

  Future<void> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      _videoFile = File(pickedFile.path);

      _controller?.dispose();

      _controller = VideoPlayerController.file(_videoFile!)
        ..initialize().then((_) {
          setState(() {}); // Rebuild with controller
        });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      _controller?.dispose();

      // _controller = VideoPlayerController.file(imageFile!)
      //   ..initialize().then((_) {
      //     setState(() {}); // Rebuild with controller
      //   });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller == null) return;
    setState(() {
      _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Optional: you can call _pickVideo here if you want tap to trigger video picking.
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Upload Video"),
        ),
        body:Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickVideo,
                    child: _controller != null && _controller!.value.isInitialized?
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: VideoPlayer(_controller!),
                    ):SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            Image.asset("assets/images/ic_upload_video.png", scale: 3,),
                            SizedBox(height: 30,),
                            MyTextWidget(data: "Select video    ",),
                          ],
                        )),
                  ),
                  SizedBox(height: 10),
                  if (_controller != null && _controller!.value.isInitialized)
                    IconButton(
                      icon: Icon(
                        _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 36,
                      ),
                      onPressed: _togglePlayPause,
                    ),
                  SizedBox(height: 20),
                  CommonTextField(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    hint: "Add Caption Here...",
                    textController: titleController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: CommonTextField(
                            hint: "Add Location",
                            textController: locController,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Flexible(
                          child: Container(
                            height: 48,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 1.5, color: fieldBorderColor)
                            ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Center(child: MyTextWidget(
                                     data: "Select Sub Category", size: 12,)),
                                 Icon(Icons.keyboard_arrow_down)
                               ],
                             ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CommonTextField(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    hint: "Description",
                    textController: descController,
                    lines: 4,
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
            CommonButton(
              onPressed: ()async{
                String imagePath = await copyAssetToFile(
                  'assets/images/thumbnail.jpg', // this is the asset path
                  'thumbnail.jpg',               // this is the filename only
                );
                controller.postVideo(
                  VideoUploadModel(
                    title: titleController.text,
                    location: locController.text,
                    description: descController.text,
                    type: "video",
                    id: controller.storageHelper.getUserModel()?.user!.id,
                    subCategory: "5449",
                    postVideo: _videoFile?.path,
                    image1: imagePath
                  ),
                );
              },
              radius: 12,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              btnTxt: "Share",
            ),
          ],
        ),
      ),
    );
  }

  Future<String> copyAssetToFile(String assetPath, String fileName) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$fileName'; // ✅ no folders here
    final file = File(filePath);
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file.path;
  }
}
