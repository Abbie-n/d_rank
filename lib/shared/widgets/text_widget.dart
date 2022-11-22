import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    Key? key,
    this.textAlign = TextAlign.center,
    this.fontSize,
    this.fontWeight,
    this.textColor,
  }) : super(key: key);

  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        color: textColor,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}
