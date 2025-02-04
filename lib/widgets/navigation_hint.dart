import 'package:flutter/material.dart';

class NavigationHint extends StatelessWidget {
  final String text; // 表示するテキスト
  final double top; // 配置の位置（高さ）
  final double left; // 配置の位置（横方向）
  final VoidCallback? onTap; // タップ時のアクション

  const NavigationHint({
    super.key,
    required this.text,
    required this.top,
    required this.left,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // 赤い線を描画
        Positioned(
          top: screenHeight * (top + 0.005), // 線の開始位置を調整
          left: screenWidth * (left + 0.04), // 線の開始位置を中央に調整
          child: CustomPaint(
            size: Size(screenWidth * 0.01, screenHeight * 0.02), // 線の大きさを調整
            painter: LinePainter(),
          ),
        ),

        // 「タップで検索」のテキストボックス
        Positioned(
          top: screenHeight * (top - 0.018), // 赤枠をさらに上に移動
          left: screenWidth * (left - 0.06),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
                vertical: screenHeight * 0.001,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFD473B), // 背景色
                borderRadius: BorderRadius.circular(4), // 角丸
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.030, // フォントサイズ
                  fontFamily: 'Noto Sans JP',
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 線を描画するカスタムペインター
class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFD473B) // 線の色
      ..strokeWidth = 2.0 // 線の太さ
      ..style = PaintingStyle.stroke;

    final start = Offset(size.width / 2, 0); // 線の開始位置（中央上）
    final end = Offset(0, size.height); // 線の終了位置（左下）

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
