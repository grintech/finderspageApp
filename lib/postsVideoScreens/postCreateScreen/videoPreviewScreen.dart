import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projects/controllers/createPostController.dart';
import 'package:projects/data/apiConstants.dart';
import 'package:projects/data/models/videoUploadModel.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';
import 'package:projects/utils/util.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/colorConstants.dart';

class VideoPickerScreen extends StatefulWidget {
  final String from;
  final String? videoId;
  final String? caption;
  final String? location;
  final String? description;
  final String? media;
  final String? title;
  final String? mediaUrl;

  const VideoPickerScreen({
    super.key,
    required this.from,
    this.caption,
    this.location,
    this.media,
    this.videoId,
    this.description,
    this.title,
    this.mediaUrl,
  });
  @override
  _VideoPickerScreenState createState() => _VideoPickerScreenState();
}

class _VideoPickerScreenState extends State<VideoPickerScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _videoFile;
  File? imageFile;
  VideoPlayerController? _controller;



  final controller = Get.put(CreatePostController());
  bool _isLoading = true;


  late var titleController = TextEditingController();
  late var descController = TextEditingController();
  late var locController = TextEditingController();
  late var captionController = TextEditingController();
  late var donationController = TextEditingController();

  var shareOn = false.obs;
  var likesOn = false.obs;
  var commentOn = false.obs;
  var donationOn = false.obs;
  var sameScreen = false.obs;



  void prefillFields(String? caption, String? location, String? title, String? description) {
    captionController.text = caption ?? '';
    locController.text = location ?? '';
    titleController.text = title ?? '';
    descController.text = description ?? '';
  }


  Future<void> _pickVideo() async {
    setState(() {
      _isLoading = true;
    });

    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      _videoFile = File(pickedFile.path);
      print("Video file picked: ${_videoFile!.path}");  // Check the file path

      _controller = VideoPlayerController.file(_videoFile!);
      await _controller!.initialize();

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print("No video selected");
    }
  }

  void _togglePlayPause() {
    if (_controller == null) return;
    setState(() {
      _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
    });
  }

  @override
  void initState() {
    super.initState();

    captionController = TextEditingController(text: widget.caption ?? '');
    locController = TextEditingController(text: widget.location ?? '');
    descController = TextEditingController(text: widget.description ?? '');
    titleController = TextEditingController(text: widget.title ?? '');
    if (widget.from == "edit" && widget.mediaUrl != null) {
      String mediaUrl = widget.mediaUrl ?? '';  // Assuming this is the mediaUrl received

// Remove square brackets and quotes if the mediaUrl is an array in string format
      mediaUrl = mediaUrl.replaceAll(RegExp(r'[\[\]"]'), '');

// Now construct the full URL
      String fullUrl = 'https://www.finderspage.com/public/images_blog_img/$mediaUrl';

          _loadVideoFromNetwork(fullUrl);
    }
  }



  Future<void> _loadVideoFromNetwork(String url) async {
    setState(() => _isLoading = true);  // Start loading

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/${url.split('/').last}');
        await file.writeAsBytes(response.bodyBytes);

        _videoFile = file;
        _controller = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {
              _isLoading = false;
            });
          });
      } else {
        print("Failed to load video from network.");
        setState(() => _isLoading = false);  // Stop loading
      }
    } catch (e) {
      print("Error loading video: $e");
      setState(() => _isLoading = false);  // Stop loading
    }
  }


  @override
  Widget build(BuildContext context) {
    final isPortrait = (_controller?.value.isInitialized == true)
        ? _controller!.value.size.height > _controller!.value.size.width
        : true;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusScopeNode());
      },
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 0,
            backgroundColor: whiteColor,
            elevation: 0),
        body:Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: widget.from == "edit"?20:70, top: 10, bottom: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.from == "edit"?
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.arrow_back_ios, color: fieldBorderColor,)):
                  const SizedBox(),
                  MyTextWidget(data: widget.from == "edit"?"        Edit Video"
                      :"Upload Video  ", size: 18, weight: FontWeight.w600,),
                  CommonButton(
                    onPressed: ()async{
                      validate();
                    },
                    radius: 6,
                    padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                    btnTxt:widget.from == "edit"?"Update":"Share",
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    GestureDetector(
                      onTap: _pickVideo,
                        child: _isLoading && widget.from == "edit"
                            ? const Center(child: CircularProgressIndicator())
                            : _controller == null
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/ic_upload_video.png", height: 140, width: 140),
                            SizedBox(height: 10),],)
                            : _controller!.value.isInitialized
                            ? Container(
                          margin: EdgeInsets.only(top: widget.from == "edit"?60:10, bottom: widget.from == "edit"?70:10),
                          width: Get.width,
                          child: SizedBox(
                            height: isPortrait ? 450 : 200,
                            child: VideoPlayer(_controller!),
                          ),
                        )
                            : const Center(child: Text("Video is not initialized, failed to load video"))),
                    if (_controller != null && _controller!.value.isInitialized)
                      GestureDetector(
                        onTap: _togglePlayPause,
                        child: Icon(
                          _controller!.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
                          size: 45,
                        ),
                      ),
                    CommonTextField(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      hint: "Add Caption Here...",
                      textController: captionController,
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
                    Row(
                      children: [
                        Icon(CupertinoIcons.music_note_2, size: 20,),
                        SizedBox(width: 10,),
                        MyTextWidget(data: "Add Music", size: 15, weight: FontWeight.w500,),
                      ],
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
                        padding: const EdgeInsets.only(top: 8, bottom: 50),
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

  validate()async{
    if(captionController.text.isEmpty){
      Utils.error("Please add Caption");
      return;
    }
    if(locController.text.isEmpty){
      Utils.error("Please add Location");
      return;
    }
    if(descController.text.isEmpty){
      Utils.error("Please add Description");
      return;
    }


    String imagePath = await copyAssetToFile(
      'assets/images/thumbnail.jpg', // this is the asset path
      'thumbnail.jpg',               // this is the filename only
    );
    widget.from == "edit"?
    controller.editVideoApi(VideoUploadModel(
        title: captionController.text,
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
    ), int.parse("${widget.videoId}")):
    controller.postVideo(VideoUploadModel(
        title: captionController.text.trim().toString(),
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
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

}


