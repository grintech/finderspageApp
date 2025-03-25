import 'package:flutter/material.dart';
import 'package:projects/utils/commonWidgets/CommonAppBar.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';
import 'package:projects/utils/util.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "About Finders Page",
        centreTxt: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: MyTextWidget(data: "FindersPage is a world wide dynamic community platform "
                  "where individuals and  brands network to market their distinctiveness."
                  " A platform combined all in one. Our mission is to empower voices "
                  "across various fields, fostering a supportive environment for growth "
                  "and connection. With user-centric design, personalized content, and "
                  "interactive features, we ensure an engaging experience for all. "
                  "FindersPage is your partner in impactful networking and unique "
                  "marketing—where every voice matters and every brand shines. ",),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CommonButton(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                margin: EdgeInsets.only(bottom: 12),
                height: 40,
                radius: 20,
                btnTxt: "Meet the Founder/CEO",
              ),
            )
          ],
        ),
      ),
    );
  }
}
