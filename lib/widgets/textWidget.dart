import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  final String lebel;

  final Color? color;

  final FontWeight? fontWeight;

  final double fontSize;

  const NewWidget({
    required this.lebel,
    this.color,
    this.fontWeight,
    this.fontSize = 18,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      lebel,
      style: TextStyle(
          color: color ?? Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w300),
    );
  }
}
