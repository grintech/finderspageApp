import 'dart:ffi';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:video_player/video_player.dart';

class MiniWidget extends StatefulWidget {
  const MiniWidget({super.key});

  @override
  _ReelsState createState() => _ReelsState();
}

final videoPlayerController = VideoPlayerController.networkUrl(
    Uri.parse('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'));

class _ReelsState extends State<MiniWidget> {
  @override
  void initState() {
    loadVideoClip();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Positioned buildPosLikeComment() {
      return Positioned(
          bottom: 100,
          right: 10,
          width: 50,
          height: 360,
          child: likeShareCommentSave());
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.black,),
          Chewie(controller: chewie), // Video Player
          const CommentWithPublisher(),
          buildPosLikeComment()
        ],
      ),
    );
  }

  void loadVideoClip() async {
    await videoPlayerController.initialize();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewie.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  final chewie = ChewieController(
    videoPlayerController: videoPlayerController,
    autoPlay: true,
    looping: true,
    allowFullScreen: true,
    autoInitialize: true,
    cupertinoProgressColors: ChewieProgressColors(),

  );
}

Column likeShareCommentSave() {
  return Column(
    children: [
      iconDetail(CupertinoIcons.hand_thumbsup, '354k'),
      const SizedBox(height: 25),
      iconDetail(CupertinoIcons.hand_thumbsdown, 'Dislike'),
      const SizedBox(height: 25),
      iconDetail(CupertinoIcons.chat_bubble_text, '872'),
      const SizedBox(height: 25),
      iconDetail(CupertinoIcons.arrow_turn_up_right, 'Share'),
      const SizedBox(height: 25),
      const Icon(CupertinoIcons.ellipsis_vertical, size: 22, color: Colors.white),
    ],
  );
}

Column iconDetail(IconData icon, String number) {
  return Column(
    children: [
      Icon(icon, size: 33, color: Colors.white,
      ),
      Text(
        number,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white
        ),
      )
    ],
  );
}

class CommentWithPublisher extends StatefulWidget {
  const CommentWithPublisher({super.key});

  @override
  _CommentWithPublisherState createState() => _CommentWithPublisherState();
}

class _CommentWithPublisherState extends State<CommentWithPublisher> {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SizedBox(height: 50),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(CupertinoIcons.search, color: whiteColor,),
            SizedBox(width: 12,),
            Icon(Icons.more_vert, color: whiteColor,)
          ],
        ),
      ),
      const Spacer(),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 40.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                circleImage(
                    'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    30),
                const SizedBox(width: 8.0),
                const Text('username', style: TextStyle(color: Colors.white)),
                const SizedBox(width: 8.0),
                Text(
                  'Follow',
                  style: textStyle,
                )
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  'My Food Plate- Description.....',
                  style: textStyle,
                ),
                Text(
                  'more',
                  style: greyText,
                )
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Music',
                  style: textStyle,
                ),
                const Spacer(),
                rectImage(
                    'https://images.pexels.com/photos/906052/pexels-photo-906052.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                    35)
              ],
            ),
          ],
        ),
      )
    ],
  );

  TextStyle greyText = const TextStyle(
    color: Colors.white,
  );

  TextStyle textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 14,
  );
}

Container circleImage(String networkImage, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: const Color(0xff7c94b6),
      image: DecorationImage(
        image: NetworkImage(networkImage),
        fit: BoxFit.cover,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
      gradient: const LinearGradient(colors: [
        Colors.red,
        Colors.pink,
      ]),
      border: Border.all(
        color: Colors.red,
        width: 2.0,
      ),
    ),
  );
}

Container rectImage(String networkImage, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: const Color(0xff7c94b6),
      image: DecorationImage(
        image: NetworkImage(networkImage),
        fit: BoxFit.cover,
      ),
      borderRadius:const BorderRadius.all(Radius.circular(8.0)),
      gradient: const LinearGradient(colors: [
        Colors.red,
        Colors.pink,
      ]),
      border: Border.all(
        color: Colors.red,
        width: 2.0,
      ),
    ),
  );
}