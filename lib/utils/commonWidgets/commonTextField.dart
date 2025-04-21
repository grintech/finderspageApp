import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colorConstants.dart';

class CommonTextField extends StatelessWidget{
  final TextInputType? keyboardType;
  final TextInputAction? keyboardAction;
  final String? hint;
  final double? height;
  final int? lines;
  final double? width;
  final Widget? suffix;
  final Widget? prefix;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final bool? obsTxt;
  final bool? read;
  final TextEditingController? textController;

  const CommonTextField({super.key, this.keyboardType, this.hint, this.suffix, this.margin, this.padding, this.height, this.width, this.obsTxt, this.textController, this.keyboardAction, this.prefix, this.lines, this.read, this.contentPadding});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      height: height,
      child: TextFormField(
        keyboardType: keyboardType,
        textInputAction: keyboardAction,
        controller: textController,
        obscureText: obsTxt ?? false,
        readOnly: read??false,
        maxLines: lines??1,
        style: TextStyle(
            fontSize: 14
        ),
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: suffix,
          prefixIcon: prefix,
          contentPadding: contentPadding??EdgeInsets.only(left: 10, right: 10, bottom: 12),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1.5, color: fieldBorderColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1.5, color: fieldBorderColor)
          ),
        ),
      ),
    );
  }

}