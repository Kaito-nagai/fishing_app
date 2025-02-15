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

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.07,
      child: Stack(
        children: [
Align(
  alignment: iconAlignment,
  child: Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_drop_up, color: Colors.blueAccent, size: 24), // 高さを業者リスト内に収める
          onPressed: onMoveUp,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minHeight: 24, minWidth: 24), // 高さを24pxに設定
        ),
        SizedBox(height: 1), // 間隔を小さく
        IconButton(
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent, size: 24), // 同じく24px
          onPressed: onMoveDown,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minHeight: 24, minWidth: 24),
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
              height: screenHeight * 0.07,
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
                  Positioned(
                    left: screenWidth * 0.332,
                    top: screenHeight * 0.036,
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
                    top: screenHeight * 0.039,
                    child: const Icon(
                      Icons.location_pin,
                      size: 16,
                      color: Color(0xFF777777),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.30,
                    top: screenHeight * 0.008,
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
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.07,
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
