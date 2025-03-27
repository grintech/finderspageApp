import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VideoPickerScreen extends StatefulWidget {
  @override
  _VideoPickerScreenState createState() => _VideoPickerScreenState();
}

class _VideoPickerScreenState extends State<VideoPickerScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _videoFile;

  Future<void> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
      });
    }
  }
  //
  // Future<void> _recordVideo() async {
  //   final XFile? recordedFile = await _picker.pickVideo(source: ImageSource.camera);
  //
  //   if (recordedFile != null) {
  //     setState(() {
  //       _videoFile = File(recordedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickVideo();
      },
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Upload Video")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_videoFile != null)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Video Selected: ${_videoFile!.path}"),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Video will be uploaded here"),
                // ElevatedButton.icon(
                //   onPressed: _pickVideo,
                //   icon: Icon(Icons.video_library),
                //   label: Text("Pick Video"),
                // ),
                // SizedBox(width: 10),
                // ElevatedButton.icon(
                //   onPressed: _recordVideo,
                //   icon: Icon(Icons.videocam),
                //   label: Text("Record Video"),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
