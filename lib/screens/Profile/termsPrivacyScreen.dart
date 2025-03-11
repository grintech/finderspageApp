import 'package:flutter/material.dart';

class TermsPrivacyScreen extends StatelessWidget {
  const TermsPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/arrow.png',
              width: 25,
              height: 25,
            ),
          ),
        ),
        centerTitle: true,
        title: Text("Terms & Conditions"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an "
            "unknown printer took a galley of type and scrambled it to make a type specimen book. It"
            " has survived not only five centuries, but also the leap into electronic typesetting, "
            "remaining essentially unchanged. It was popularised in the 1960s with the release of "
            "Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing "
            "software like Aldus PageMaker including versions of Lorem Ipsum."),
      ),
    );
  }
}
