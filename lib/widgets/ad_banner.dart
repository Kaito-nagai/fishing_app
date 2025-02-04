import 'package:flutter/material.dart';
import 'package:fishing_app/widgets/ad_placeholder.dart';

class AdBanner extends StatelessWidget {
  final double positionTop;
  final VoidCallback onTap;

  const AdBanner({
    super.key,
    required this.positionTop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      left: screenWidth * 0.04,
      top: screenHeight * positionTop,
      child: GestureDetector(
        onTap: onTap,
        child: AdPlaceholder(
          adContent: null,
          showPlaceholder: true,
          width: screenWidth * 0.92,
          height: screenHeight * 0.13,
        ),
      ),
    );
  }
}
