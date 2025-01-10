import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = []; // お気に入りリスト

  List<Map<String, dynamic>> get favorites => _favorites;

  // お気に入りに追加
  void addFavorite(Map<String, dynamic> item) {
    if (!_favorites.any((fav) => fav['id'] == item['id'])) {
      _favorites.add(item);
      notifyListeners(); // 状態変更を通知
    }
  }

  // お気に入りを削除
  void removeFavorite(String id) {
    _favorites.removeWhere((item) => item['id'] == id);
    notifyListeners(); // 状態変更を通知
  }

  // お気に入りに登録されているか確認
  bool isFavorite(String id) {
    return _favorites.any((item) => item['id'] == id);
  }

  // リストを更新 (UIをリビルド)
  void updateFavorites() {
    notifyListeners(); // UIをリビルド
  }
}
