import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projects/utils/colorConstants.dart';

class ImageView extends StatelessWidget {

  final String? image;
  double? progressSize = 32.0;
  final  double? height;
  final  double? width;
  final  String? placeholder;
  final  EdgeInsetsGeometry? padding;
  final  EdgeInsetsGeometry? margin;
  final  Widget? errorWidget;
  final  BoxFit? boxFit;

  ImageView({
    Key? key,
    this.image,
    this.height,
    this.width,
    this.progressSize,
    this.placeholder,
    this.errorWidget,
    this.boxFit,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      child: (image == null)
          ? errorWidget ?? Image.asset(placeholder ?? "assets/images/ic_user.png", fit: BoxFit.cover)
          : (image!.contains("http") == true)
          ? CachedNetworkImage(
        imageUrl: image!,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: boxFit ?? BoxFit.cover,
              ),
            ),
          );
        },
        placeholder: (context, url) {
          return Center(
            child: SizedBox(
              width: progressSize,
              height: progressSize,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(fieldBorderColor),
                strokeWidth: 3.5,
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return errorWidget ?? Image.asset(placeholder ?? "assets/images/ic_user.png", fit: boxFit ?? BoxFit.cover);
        },
      )
          : Image.file(File(image!), fit: boxFit ?? BoxFit.cover),
    );
  }
}

