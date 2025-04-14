import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MediaWidget extends StatefulWidget {
  final String mediaUrl;
  final double screenRatio;
  const MediaWidget({super.key, required this.mediaUrl, required this.screenRatio});

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  VideoPlayerController? _controller;



  bool get isVideo {
    final lowerUrl = widget.mediaUrl.toLowerCase();
    return lowerUrl.endsWith(".mp4") || lowerUrl.endsWith(".mov") || lowerUrl.endsWith(".avi");
  }

  @override
  void initState() {
    super.initState();
    if (isVideo) {
      _controller = VideoPlayerController.network(widget.mediaUrl)
        ..initialize().then((_) {
          setState(() {}); // refresh after initialized
          _controller!.setLooping(true);
          // _controller!.play(); // autoplay
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _handleVideoTap() {
    if (_controller != null && _controller!.value.isInitialized) {
      setState(() {
        _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: isVideo
            ? (_controller != null && _controller!.value.isInitialized
            ? GestureDetector(
          onTap: () => _handleVideoTap(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      height: _controller?.value.size.height,
                      width: _controller?.value.size.width,
                      child: VideoPlayer(_controller!)),
                  if (!_controller!.value.isPlaying)
                    const Icon(
                      Icons.play_arrow,
                      size: 64,
                      color: Colors.white70,
                    ),
                ],
              ),
            )
            : Center(child: CircularProgressIndicator()))
            : Image.network(
          widget.mediaUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Image.asset(
            "assets/images/no_image.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
