import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/util.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';

class VideoFeedScreen extends StatefulWidget {
  @override
  _VideoFeedScreenState createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> with WidgetsBindingObserver {
  final List<String> videoUrls = [
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
  ];

  final PageController _pageController = PageController();
  late List<VideoPlayerController> _controllers;

  int _currentIndex = 0; // Track current video index

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Listen for app lifecycle changes
    _controllers = videoUrls
        .map((url) => VideoPlayerController.networkUrl(Uri.parse(url)))
        .toList();

    for (var controller in _controllers) {
      controller.initialize();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Resume playing when the screen is active
      _controllers[_currentIndex].play();
    } else {
      // Pause all videos when the screen is inactive
      for (var controller in _controllers) {
        controller.pause();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        onPageChanged: (index) {
          _controllers[_currentIndex].pause(); // Pause the previous video
          _currentIndex = index;
          _controllers[_currentIndex].play(); // Play the new video
        },
        itemBuilder: (context, index) {
          return MiniWidget(videoController: _controllers[index]);
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class MiniWidget extends StatefulWidget {
  final VideoPlayerController videoController;
  const MiniWidget({Key? key, required this.videoController}) : super(key: key);

  @override
  _MiniWidgetState createState() => _MiniWidgetState();
}

class _MiniWidgetState extends State<MiniWidget> {
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
      videoPlayerController: widget.videoController,
      autoPlay: false, // Make sure autoPlay is false
      looping: true,
      allowFullScreen: true,
      autoInitialize: true,
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black),
        Chewie(controller: chewieController),
      ],
    );
  }

  @override
  void dispose() {
    chewieController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }
}

