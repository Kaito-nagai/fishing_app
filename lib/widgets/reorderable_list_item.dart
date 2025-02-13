import 'package:flutter/material.dart';

class ReorderableListItem extends StatelessWidget {
  final String title;
  final String location;
  final String imagePath;
  final bool isFavorite;
  final VoidCallback? onFavoritePressed;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  const ReorderableListItem({
    super.key,
    required this.title,
    required this.location,
    required this.imagePath,
    required this.isFavorite,
    this.onFavoritePressed,
    required this.onMoveUp,
    required this.onMoveDown,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.08, // 高さを少し調整
      child: Stack(
        children: [
          // 並べ替えボタンエリア（上下中央に配置）
          Positioned(
            left: screenWidth * 0.02, // 左端に配置
            top: screenHeight * 0.02, // 業者リストの中央に配置
            child: SizedBox(
              width: screenWidth * 0.07, // ボタンの幅を調整
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // ボタンを上下中央に
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_up, color: Colors.blueAccent, size: 26),
                    onPressed: onMoveUp,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent, size: 26),
                    onPressed: onMoveDown,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
          // 業者リストアイテム
          Positioned(
            left: screenWidth * 0.12, // ボタンと業者リストの間隔を調整
            top: 3,
            child: Container(
              width: screenWidth * 0.85, // 横幅を調整
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                color: const Color(0xFF2E2E2E),
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(64, 0, 0, 0),
                    offset: Offset(4, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // お気に入りボタン
                  Positioned(
                    right: 1,
                    top: screenHeight * 0.015,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: screenWidth * 0.053,
                      ),
                      onPressed: onFavoritePressed,
                    ),
                  ),
                  // 業者の位置情報
                  Positioned(
                    left: screenWidth * 0.332,
                    top: screenHeight * 0.038,
                    child: Opacity(
                      opacity: 0.50,
                      child: Text(
                        location,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.034,
                          fontFamily: 'Noto Sans JP',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  // ピンアイコン
                  Positioned(
                    left: screenWidth * 0.295,
                    top: screenHeight * 0.040,
                    child: const Icon(
                      Icons.location_pin,
                      size: 16,
                      color: Color(0xFF777777),
                    ),
                  ),
                  // 業者名
                  Positioned(
                    left: screenWidth * 0.30,
                    top: screenHeight * 0.010,
                    child: SizedBox(
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.06,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Noto Sans JP',
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  // 業者画像
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.08,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
