import 'package:flutter/material.dart';

class ReorderableListItem extends StatelessWidget {
  final String title;
  final String location;
  final String imagePath;
  final bool isFavorite;
  final VoidCallback? onFavoritePressed;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  final Alignment iconAlignment;

  const ReorderableListItem({
    super.key,
    required this.title,
    required this.location,
    required this.imagePath,
    required this.isFavorite,
    this.onFavoritePressed,
    required this.onMoveUp,
    required this.onMoveDown,
    this.iconAlignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final itemHeight = screenHeight * 0.07; // 各業者リストの高さ

    return SizedBox(
      width: double.infinity,
      height: itemHeight,
      child: Stack(
        children: [
          Align(
            alignment: iconAlignment,
            child: SizedBox(
              height: itemHeight, // 業者リストの高さと合わせる
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 均等配置
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_up, color: Colors.blueAccent),
                    onPressed: onMoveUp,
                    iconSize: itemHeight * 0.4, // リスト高さの40%で調整
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                    onPressed: onMoveDown,
                    iconSize: itemHeight * 0.4, // 同じく40%で調整
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.12,
            top: 0,
            child: Container(
              width: screenWidth * 0.85,
              height: itemHeight,
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
                  Positioned(
                    right: 1,
                    top: itemHeight * 0.15,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: screenWidth * 0.053,
                      ),
                      onPressed: onFavoritePressed,
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.332,
                    top: itemHeight * 0.5,
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
                    left: screenWidth * 0.295,
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
                          fontSize: 16,
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
