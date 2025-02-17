import 'package:flutter/material.dart';

class ReorderableListItem extends StatelessWidget {
  final String title;
  final String location;
  final String imagePath;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  const ReorderableListItem({
    super.key,
    required this.title,
    required this.location,
    required this.imagePath,
    this.onMoveUp,
    this.onMoveDown,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final itemHeight = screenHeight * 0.07;

    return SizedBox(
      width: double.infinity,
      height: itemHeight,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 0),
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
                  // 🔹 左に「上アイコン」 - 中央配置＆サイズ調整
                  Positioned(
                    right: screenWidth * 0.08, // アイコン間の幅を狭く
                    top: itemHeight * 0.02,    // 高さの中央に配置
                    child: IconButton(
                      icon: const Icon(Icons.arrow_drop_up, color: Colors.blue),
                      iconSize: screenWidth * 0.13, // サイズを大きく
                      onPressed: onMoveUp,
                    ),
                  ),
                  // 🔹 右に「下アイコン」 - 中央配置＆サイズ調整
                  Positioned(
                    right: 1,                  // 右端に配置
                    top: itemHeight * 0.02,    // 高さの中央に配置
                    child: IconButton(
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                      iconSize: screenWidth * 0.13, // サイズを大きく
                      onPressed: onMoveDown,
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.332,
                    top: itemHeight * 0.53,
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
                  Positioned(
                    left: screenWidth * 0.290,
                    top: itemHeight * 0.55,
                    child: const Icon(
                      Icons.location_pin,
                      size: 16,
                      color: Color(0xFF777777),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.30,
                    top: itemHeight * 0.1,
                    child: SizedBox(
                      width: screenWidth * 0.3,
                      height: itemHeight * 0.8,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Noto Sans JP',
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: screenWidth * 0.25,
                      height: itemHeight,
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
