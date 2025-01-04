import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final String favoriteKey;
  final String favoriteName;
  final int favoriteCount;
  final VoidCallback onFavoriteUpdated;

  const FavoriteButton({
    super.key,
    required this.favoriteKey,
    required this.favoriteName,
    required this.favoriteCount,
    required this.onFavoriteUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.favorite, color: Colors.red),
      onPressed: () {
        // お気に入り更新処理
        onFavoriteUpdated();
      },
    );
  }
}
