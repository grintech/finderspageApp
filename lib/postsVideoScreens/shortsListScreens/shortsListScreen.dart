import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:projects/utils/imageViewer.dart';
import 'package:projects/utils/util.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';

class VideoFeedScreen extends StatefulWidget {
  @override
  _VideoFeedScreenState createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  final List<String> videoUrls = [
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
  ];

  final PageController _pageController = PageController();
  late List<VideoPlayerController> _controllers;



  @override
  void initState() {
    super.initState();
    _controllers = videoUrls.map((url) => VideoPlayerController.networkUrl(Uri.parse(url))).toList();
    for (var controller in _controllers) {
      controller.initialize();
    }
    _controllers.first.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        onPageChanged: (index) {
          for (var controller in _controllers) {
            controller.pause();
          }
          _controllers[index].play();
        },
        itemBuilder: (context, index) {
          return MiniWidget(videoController: _controllers[index]);
        },
      ),
    );
  }

  @override
  void dispose() {
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
  _ReelsState createState() => _ReelsState();
}

class _ReelsState extends State<MiniWidget> {
  late ChewieController chewieController;

  var like = true;
  var disLike = true;
  var comment = true;
  var share = true;

  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
      videoPlayerController: widget.videoController,
      autoPlay: false,
      looping: true,
      allowFullScreen: true,
      autoInitialize: true,
      cupertinoProgressColors: ChewieProgressColors(),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(color: Colors.black),
          Chewie(controller: chewieController), // Video Player
          const CommentWithPublisher(),
          Positioned(
            bottom: 100,
            right: 10,
            width: 50,
            height: 300,
            child: likeShareCommentSave(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    chewieController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }
  Column likeShareCommentSave() {

    return Column(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                like = !like;
                disLike = true;
              });
            },
            child: like
                ?iconDetail(CupertinoIcons.hand_thumbsup, '354k')
                :iconDetail(CupertinoIcons.hand_thumbsup_fill, "355k")),
        const SizedBox(height: 25),
        GestureDetector(
          onTap: () {
            setState(() {
              disLike = !disLike;
              like = true;
            });
          },
            child: disLike?iconDetail(CupertinoIcons.hand_thumbsdown, 'Dislike')
                :iconDetail(CupertinoIcons.hand_thumbsdown_fill, 'Dislike')),
        const SizedBox(height: 25),
        GestureDetector(
            onTap: () {
              setState(() {
                comment = false;
              });
              showCommentBox();
            },
            child: iconDetail(CupertinoIcons.chat_bubble_text, '872')),
        const SizedBox(height: 25),
        iconDetail(CupertinoIcons.arrow_turn_up_right, 'Share'),
      ],
    );
  }

  Future<dynamic> showCommentBox(){
    return showModalBottomSheet(
      isDismissible: false,
        context: context,
        builder: (context){
          return Container(
            height: 400,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTextWidget(data: "Comment 5", size: 14, weight: FontWeight.w600,),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              Get.back();
                            });
                          },
                          child: Icon(CupertinoIcons.multiply))
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                      itemBuilder: (context, index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ImageView(
                                      height: 20, width: 20,
                                      margin: EdgeInsets.only(right: 8),
                                    ),
                                    MyTextWidget(data: "@FilmyUpdates",),
                                    MyTextWidget(data: " 10 hrs ago",),
                                  ],
                                ),
                                Icon(Icons.more_vert)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, top: 6, bottom: 8),
                              child: MyTextWidget(data: "Awesome Video",),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Row(
                                children: [
                                  Icon(Icons.thumb_up_alt_outlined, size: 18,),
                                  SizedBox(width: 8,),
                                  Icon(Icons.thumb_down_alt_outlined, size: 18,),
                                  SizedBox(width: 8,),
                                  Icon(Icons.message_outlined, size: 18,)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, top: 8, bottom: 15),
                              child: Row(
                                children: [
                                  MyTextWidget(data: "5 Replies",),
                                  Icon(Icons.keyboard_arrow_right, size: 18,)
                                ],
                              ),
                            )
                          ],
                        );
                      }
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}



Column iconDetail(IconData icon, String number) {
  return Column(
    children: [
      Icon(icon, size: 33, color: Colors.white),
      Text(number, style: const TextStyle(fontSize: 14, color: Colors.white)),
    ],
  );
}

class CommentWithPublisher extends StatelessWidget {
  const CommentWithPublisher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(CupertinoIcons.search, color: Colors.white),
              SizedBox(width: 12),
              Icon(Icons.more_vert, color: Colors.white)
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  circleImage(
                      'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg', 30),
                  const SizedBox(width: 8.0),
                  const Text('username', style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 8.0),
                  Text('Follow', style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 10.0),
              Text('My Food Plate - Description.....', style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        )
      ],
    );
  }
}

Container circleImage(String networkImage, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      image: DecorationImage(image: NetworkImage(networkImage), fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(50.0),
      border: Border.all(color: Colors.red, width: 2.0),
    ),
  );
}
