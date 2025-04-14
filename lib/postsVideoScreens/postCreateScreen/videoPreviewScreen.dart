import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
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
  final captionController = TextEditingController();
  final donationController = TextEditingController();

  var shareOn = false.obs;
  var likesOn = false.obs;
  var commentOn = false.obs;
  var donationOn = false.obs;

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
          actions: [
            CommonButton(
              margin: EdgeInsets.only(right: 20),
              onPressed: ()async{
                String imagePath = await copyAssetToFile(
                  'assets/images/thumbnail.jpg', // this is the asset path
                  'thumbnail.jpg',               // this is the filename only
                );
                controller.postVideo(VideoUploadModel(
                      title: titleController.text,
                      location: locController.text,
                      description: descController.text,
                      type: "video",
                      shares: shareOn.value == true?1:0,
                      likesBtn: likesOn.value == true?"1":"0",
                      commentOption: commentOn.value == true?1:0,
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
        body:SingleChildScrollView(
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
                    height: 170,
                    child: Column(
                      children: [
                        Image.asset("assets/images/ic_upload_video.png", scale: 5,),
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
              SizedBox(height: 10),
              CommonTextField(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                hint: "Add Title Here...",
                textController: titleController,
              ),
              CommonTextField(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                hint: "Add Location",
                textController: locController,
              ),
              CommonTextField(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                hint: "Add Description",
                lines: 3,
                textController: descController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextWidget(data: "Share",),
                    Obx(()=>FlutterSwitch(
                        height: 20, width: 40,
                        toggleSize: 12,
                        activeColor: fieldBorderColor,
                        value: shareOn.value,
                        onToggle:(val){
                          shareOn.value = val;
                        }
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextWidget(data: "Comment",),
                    Obx(()=>FlutterSwitch(
                        height: 20, width: 40,
                        toggleSize: 12,
                        activeColor: fieldBorderColor,
                        value: commentOn.value,
                        onToggle:(val){
                          commentOn.value = val;
                        }
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric( vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextWidget(data: "Likes",),
                    Obx(()=>FlutterSwitch(
                        height: 20, width: 40,
                        toggleSize: 12,
                        activeColor: fieldBorderColor,
                        value: likesOn.value,
                        onToggle:(val){
                          likesOn.value = val;
                        }
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric( vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextWidget(data: "Tips & Donation (Optional)",),
                    Obx(()=>FlutterSwitch(
                        height: 20, width: 40,
                        toggleSize: 12,
                        activeColor: fieldBorderColor,
                        value: donationOn.value,
                        onToggle:(val){
                          donationOn.value = val;
                        }
                    )),
                  ],
                ),
              ),
            ],
          ),
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
