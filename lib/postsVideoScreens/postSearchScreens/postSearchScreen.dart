import 'package:flutter/material.dart';
import 'package:projects/utils/commonWidgets/commonTextField.dart';

class PostSearchScreen extends StatelessWidget {
  const PostSearchScreen({super.key});

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
            )
          ],
        ),
      ),
    );
  }
}
