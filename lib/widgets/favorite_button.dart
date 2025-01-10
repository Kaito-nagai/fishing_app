import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final String favoriteKey;
  final bool initialIsFavorite;
  final VoidCallback onFavoriteUpdated;

  const FavoriteButton({
    super.key,
    required this.favoriteKey,
    this.initialIsFavorite = false, // デフォルトは false
    required this.onFavoriteUpdated,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialIsFavorite; // 初期状態を設定
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      debugPrint(isFavorite
          ? '❤️ Added to favorites: ${widget.favoriteKey}'
          : '🗑️ Removed from favorites: ${widget.favoriteKey}');
    });

    // 状態更新後にコールバックを呼び出す
    widget.onFavoriteUpdated();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      tooltip: isFavorite ? 'お気に入りから削除' : 'お気に入りに追加',
      onPressed: _toggleFavorite,
    );
  }
}
