import 'package:flutter/material.dart';

class AdPlaceholder extends StatelessWidget {
  final Widget? adContent; // 外部広告コンテンツを受け取る（デフォルトは null）
  final bool showPlaceholder; // プレースホルダーを表示するかどうか
  final double width; // 広告エリアの幅
  final double height; // 広告エリアの高さ

  const AdPlaceholder({
    super.key,
    this.adContent,
    this.showPlaceholder = false,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    // 画面サイズを取得
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 基準デバイスのサイズ（デザインから取得）
    const double baseWidth = 390.0; // デザインの幅
    const double baseHeight = 844.0; // デザインの高さ

    // 比率計算
    final double widthRatio = screenWidth / baseWidth;
    final double heightRatio = screenHeight / baseHeight;

    return Positioned(
      left: 17 * widthRatio, // X = 17px を画面幅に応じて調整
      top: 73 * heightRatio, // Y = 73px を画面高さに応じて調整
      child: Container(
        width: 360 * widthRatio, // 幅をデザイン基準で調整
        height: 111 * heightRatio, // 高さをデザイン基準で調整
        decoration: BoxDecoration(
          color: Colors.grey[200], // プレースホルダー背景色
          borderRadius: BorderRadius.circular(screenWidth * 0.03), // 角丸
        ),
        child: showPlaceholder
            ? Center(
                child: Text(
                  '広告エリア', // プレースホルダーテキスト
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: screenWidth * 0.04, // フォントサイズを画面幅に基づいて調整
                    decoration: TextDecoration.none,
                  ),
                ),
              )
            : adContent ?? Container(), // 広告コンテンツがあれば表示、なければ空
      ),
    );
  }
}

