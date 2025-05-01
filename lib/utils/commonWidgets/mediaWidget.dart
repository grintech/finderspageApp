import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

// class MediaWidget extends StatelessWidget {
//   final VideoPlayerController controller;
//
//   const MediaWidget({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     final isPortrait = controller.value.size.height > controller.value.size.width;
//
//     return GestureDetector(
//       onTap: () {
//         if (controller.value.isPlaying) {
//           controller.pause();
//         } else {
//           controller.play();
//         }
//       },
//       child: buildMediaWidget(controller),
//     );
//   }
//
//   Widget buildMediaWidget(VideoPlayerController controller, String mediaUrl, bool isPortrait) {
//     final lowerUrl = mediaUrl.toLowerCase();
//     final isVideo = lowerUrl.endsWith(".mp4") || lowerUrl.endsWith(".mov") || lowerUrl.endsWith(".avi");
//
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         isVideo
//             ? (isPortrait
//             ? SizedBox(
//           width: Get.width,
//           height: Get.width * controller.value.aspectRatio,
//           child: VideoPlayer(controller),
//         )
//             : Center(
//           child: FittedBox(
//             fit: BoxFit.contain,
//             child: SizedBox(
//               width: controller.value.size.width,
//               height: controller.value.size.height,
//               child: VideoPlayer(controller),
//             ),
//           ),
//         ))
//             : Image.network(
//           mediaUrl,
//           width: Get.width,
//           fit: BoxFit.cover,
//           errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
//         ),
//       ],
//     );
//   }
//
//
// // void _handleVideoTap() {
//   //   if (controller != null && controller.value.isInitialized) {
//   //       controller.value.isPlaying ? controller.pause() : controller.play();
//   //   }
//   // }
//
//   // Widget _buildVideoPlayer() {
//   //   final videoSize = controller.value.size;
//   //   final isPortrait = videoSize.height > videoSize.width;
//   //
//   //   return GestureDetector(
//   //     onTap: _handleVideoTap,
//   //     child: Stack(
//   //       alignment: Alignment.center,
//   //       children: [
//   //         isPortrait
//   //             ? SizedBox(
//   //           width: Get.width,
//   //           height: Get.width * (videoSize.height / videoSize.width),
//   //           child: VideoPlayer(controller),
//   //         )
//   //             : Center(
//   //           child: FittedBox(
//   //             fit: BoxFit.contain,
//   //             child: SizedBox(
//   //               width: videoSize.width,
//   //               height: videoSize.height,
//   //               child: VideoPlayer(controller),
//   //             ),
//   //           ),
//   //         ),
//   //         if (!controller.value.isPlaying)
//   //           const Icon(
//   //             Icons.play_arrow,
//   //             size: 64,
//   //             color: Colors.white70,
//   //           ),
//   //       ],
//   //     ),
//   //   );
//   // }
// }


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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: isVideo
          ? (_controller != null && _controller!.value.isInitialized
          ? _buildVideoPlayer()
          : Center(child: CircularProgressIndicator()))
          : Image.network(
        widget.mediaUrl,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Image.asset(
          "assets/images/no_image.png", height: 20, width: 20,
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    final videoSize = _controller!.value.size;
    final isPortrait = videoSize.height > videoSize.width;

    return GestureDetector(
      onTap: _handleVideoTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          isPortrait
              ? SizedBox(
            width: Get.width,
            height: Get.width * (videoSize.height / videoSize.width),
            child: VideoPlayer(_controller!),
          )
              : Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: videoSize.width,
                height: videoSize.height,
                child: VideoPlayer(_controller!),
              ),
            ),
          ),
          if (!_controller!.value.isPlaying)
            const Icon(
              Icons.play_arrow,
              size: 64,
              color: Colors.white70,
            ),
        ],
      ),
    );
  }

}