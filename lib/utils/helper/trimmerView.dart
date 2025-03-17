// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:projects/utils/commonWidgets/CommonAppBar.dart';
// import 'package:video_trimmer/video_trimmer.dart';
//
// class TrimmerView extends StatefulWidget {
//
//   final File file;
//
//   const TrimmerView({Key? key, required this.file}) : super(key: key);
//
//   @override
//   State<TrimmerView> createState() => _TrimmerViewState();
// }
//
// class _TrimmerViewState extends State<TrimmerView> {
//
//   final Trimmer _trimmer = Trimmer();
//
//   double _startValue = 0.0;
//   double _endValue = 0.0;
//
//   bool _isPlaying = false;
//   bool _progressVisibility = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadVideo();
//   }
//
//   void _loadVideo() {
//     _trimmer.loadVideo(videoFile: widget.file);
//   }
//
//   _saveVideo() {
//     setState(() {
//       _progressVisibility = true;
//     });
//
//     _trimmer.saveTrimmedVideo(
//       startValue: _startValue,
//       endValue: _endValue,
//       onSave: (outputPath) async {
//         setState(() {
//           _progressVisibility = false;
//         });
//         debugPrint('OUTPUT PATH: $outputPath');
//         // MediaInfo info = await VideoCompress.getMediaInfo(outputPath!);
//         // debugPrint("OUTPUT FILE DATA\nfilesize => ${info.filesize}\duration => ${info.duration}");
//         Get.back(result: outputPath);
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (Navigator.of(context).userGestureInProgress) {
//           return false;
//         } else {
//           return true;
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: CommonAppBar(),
//         body: Center(
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Visibility(
//                   visible: _progressVisibility,
//                   child: const LinearProgressIndicator(
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 Expanded(child: VideoViewer(trimmer: _trimmer)),
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TrimViewer(
//                       trimmer: _trimmer,
//                       viewerHeight: 50.0,
//                       viewerWidth: MediaQuery.of(context).size.width,
//                       durationStyle: DurationStyle.FORMAT_MM_SS,
//                       maxVideoLength: const Duration(seconds:15),
//                       editorProperties: TrimEditorProperties(
//                         borderPaintColor: Colors.yellow,
//                         borderWidth: 4,
//                         borderRadius: 5,
//                         circlePaintColor: Colors.yellow.shade800,
//                       ),
//                       areaProperties: TrimAreaProperties.edgeBlur(thumbnailQuality: 10),
//                       onChangeStart: (value) => _startValue = value,
//                       onChangeEnd: (value) => _endValue = value,
//                       onChangePlaybackState: (value) => setState(() => _isPlaying = value),
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 40.0, color: Colors.white),
//                   onPressed: () async {
//                     bool playbackState = await _trimmer.videoPlaybackControl(
//                       startValue: _startValue,
//                       endValue: _endValue,
//                     );
//                     setState(() => _isPlaying = playbackState);
//                   },
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       onPressed: _progressVisibility ? null : () => Navigator.pop(context),
//                       child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w500),),
//                     ),
//                     const SizedBox(width: 32),
//                     ElevatedButton(
//                       onPressed: _progressVisibility ? null : () => _saveVideo(),
//                       child: const Text("Upload Video", style: TextStyle(fontWeight: FontWeight.w500),),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }