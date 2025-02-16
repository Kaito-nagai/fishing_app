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
    final itemHeight = screenHeight * 0.07;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate( // 上のアイコンを少し上に移動
          offset: const Offset(0, -5),
          child: IconButton(
            icon: const Icon(Icons.arrow_drop_up, color: Colors.blueAccent),
            onPressed: onMoveUp,
            iconSize: itemHeight * 0.6,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        Align( // 間隔を調整
          alignment: Alignment.center,
          child: SizedBox(height: 0), 
        ),
        Transform.translate( // 下のアイコンを少し上に移動して間隔を詰める
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
    );
  }
}
