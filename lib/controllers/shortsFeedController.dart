import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoFeedController extends GetxController {
  List<VideoPlayerController> videoControllers = [];
  RxInt currentIndex = 0.obs;

  void initializeVideos(List<String> videoUrls) {
    videoControllers = videoUrls.map((url) => VideoPlayerController.networkUrl(Uri.parse(url))).toList();
    for (var controller in videoControllers) {
      controller.initialize();
    }
  }

  void playCurrentVideo() {
    if (videoControllers.isNotEmpty) {
      videoControllers[currentIndex.value].play();
    }
  }

  void pauseAllVideos() {
    for (var controller in videoControllers) {
      controller.pause();
    }
  }

  void onPageChanged(int index) {
    pauseAllVideos();
    currentIndex.value = index;
    playCurrentVideo();
  }

  @override
  void dispose() {
    for (var controller in videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
