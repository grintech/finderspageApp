import 'package:flutter/material.dart';
import 'package:projects/utils/colorConstants.dart';

class MyTextWidget extends StatelessWidget {
  final String? data;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextOverflow? overflow;

  const MyTextWidget({super.key, this.data, this.size, this.color, this.weight, this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      data??"",
      style: TextStyle(
          color: color ?? blackColor,
          overflow: overflow,
          fontSize: size ?? 14.0,
          fontWeight: weight
      ),
    );
  }
}
