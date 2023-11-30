import 'package:flutter/material.dart';


class HeadingText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontweight;

  HeadingText({required this.text, this.fontSize=24, this.fontweight=FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize:fontSize,
        fontWeight: fontweight,
      ),
    );
  }
}
class MainText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontweight;

  MainText({required this.text, this.fontSize=14, this.fontweight=FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize:fontSize,
        fontWeight: fontweight,
      ),
    );
  }
}
class BodyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontweight;

  BodyText({required this.text, this.fontSize=16, this.fontweight=FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize:fontSize,
        fontWeight: fontweight,
      ),
    );
  }
}
