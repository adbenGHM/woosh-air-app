import 'package:flutter/material.dart';
import 'package:woosh/AppMeta/metaData.dart';

/// CUSTOM TEXT FIELD WHRER ALL THE BASIC
/// SETUP AND DISIGN IS DONE
class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final int? maxLines;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final bool wrap;

  CustomText(
    this.text, {
    Key? key,
    this.fontSize = secondaryFontSize,
    this.maxLines,
    this.fontWeight = FontWeight.w300,
    this.color,
    this.textAlign,
    this.decoration,
    this.wrap = false,
  }) : super(key: key);

  CustomText.primary(
    this.text, {
    Key? key,
    this.fontSize = primaryFontSize,
    this.maxLines,
    this.fontWeight = FontWeight.w600,
    this.color,
    this.textAlign,
    this.decoration,
    this.wrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: wrap ? null : TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'assets/fonts/OpenSans-Regular.ttf',
        color: color,
        decoration: decoration,
      ),
    );
  }
}
