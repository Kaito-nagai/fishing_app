import 'package:flutter/material.dart';

class LabelTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final double positionTop;
  final double positionLeft;
  final double width;
  final double height;

  const LabelTextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.positionTop,
    required this.positionLeft,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      left: screenWidth * positionLeft,
      top: screenHeight * positionTop,
      child: SizedBox(
        width: screenWidth * width,
        height: screenHeight * height,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * fontSize,
            fontFamily: 'Noto Sans JP',
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
