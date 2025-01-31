import 'package:flutter/material.dart';

class AdPlaceholder extends StatelessWidget {
  final Widget? adContent; // 外部広告コンテンツを受け取る（デフォルトは null）
  final bool showPlaceholder; // プレースホルダーを表示するかどうか
  final double width; // 広告エリアの幅
  final double height; // 広告エリアの高さ


  const AdPlaceholder({
    super.key, // super パラメータを使用
    this.adContent,
    this.showPlaceholder = false,
    required this.width, // width を required にする
    required this.height, // height を required にする
  });

  @override
  Widget build(BuildContext context) {
    // 画面サイズを取得
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.92, // 横幅は画面幅の 92%
      height: screenHeight * 0.13, // 高さは画面高さの 13%（必要に応じて調整可能）
      decoration: BoxDecoration(
        color: Colors.grey[200], // プレースホルダー背景色
        borderRadius: BorderRadius.circular(screenWidth * 0.03), // 角を画面幅に基づいて調整
      ),
      child: showPlaceholder
          ? Center(
              child: Text(
                '広告エリア', // プレースホルダーテキスト
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: screenWidth * 0.04, // フォントサイズを画面幅に応じて調整
                  decoration: TextDecoration.none,
                ),
              ),
            )
          : adContent ?? Container(), // 広告コンテンツがあれば表示、なければ空
    );
  }
}
