import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String? btnTxt;
  final double? radius;
  final double? height;
  final double? txtSize;
  final double? width;
  final FontWeight? txtWeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onPressed;

  const CommonButton({super.key, this.btnTxt, this.radius, this.height, this.width, this.padding,
    this.margin, this.onPressed, this.txtSize, this.txtWeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius??0),
          gradient: LinearGradient(
            colors: [Color(0xFFDC7228), Color(0xFFA54DB7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 1.0], // 30% and 100%
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Text(btnTxt??"",
          style: TextStyle(
            fontSize: txtSize??16,
            fontWeight: txtWeight??FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
