import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';

class PostSearchScreen extends StatelessWidget {
  PostSearchScreen({super.key});

  final List<String> colors = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            CommonTextField(
              prefix: Icon(Icons.search),
              hint: "Search",
            ),
      Expanded(
        child:  GridView.custom(
          padding: EdgeInsets.symmetric(vertical: 12),
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 2),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: colors.length,
                (context, index) {
              return Container(
                color: Colors.red,
                width: Get.width,
                child: Image.asset(
                  colors[index % colors.length],
                  fit: BoxFit.cover,
                ),
              );
            },
            // Make the list dynamic
          ),
        ),
      ),
          ],
        ),
      ),
    );
  }
}
