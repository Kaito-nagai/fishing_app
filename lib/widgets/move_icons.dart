import 'package:flutter/material.dart';

class MoveIcons extends StatelessWidget {
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  const MoveIcons({
    super.key,
    required this.onMoveUp,
    required this.onMoveDown,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemHeight = screenHeight * 0.07;

    return SizedBox(
      height: itemHeight,
      width: screenWidth * 0.10, // 横幅を調整
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.translate(
            offset: const Offset(0, -5),
            child: IconButton(
              icon: const Icon(Icons.arrow_drop_up, color: Colors.blueAccent),
              onPressed: onMoveUp,
              iconSize: itemHeight * 0.6,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -30),
            child: IconButton(
              icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
              onPressed: onMoveDown,
              iconSize: itemHeight * 0.6,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}
