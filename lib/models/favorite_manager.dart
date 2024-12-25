import 'package:flutter/foundation.dart'; // debugPrint用
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'favorite_item.dart';

class FavoriteManager {
  static const String _favoritesKey = 'favorites';

  // お気に入りリストを取得
static Future<List<FavoriteItem>> loadFavorites() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_favoritesKey);

    if (favoritesJson == null) {
      return [];
    }

    final List<dynamic> decoded = json.decode(favoritesJson);
    return decoded.map((item) => FavoriteItem.fromJson(item)).toList();
  } catch (e) {
    debugPrint('❌ お気に入りリストの読み込み中にエラーが発生しました: $e');
    return [];
  }
}

// お気に入りリストを保存
static Future<void> saveFavorites(List<FavoriteItem> favorites) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(favorites.map((item) => item.toJson()).toList());
    await prefs.setString(_favoritesKey, encoded);
  } catch (e) {
    debugPrint('❌ お気に入りリストの保存中にエラーが発生しました: $e');
  }
}


  // アイテムを追加
static Future<void> addFavorite(FavoriteItem item) async {
  final favorites = await loadFavorites();
  final exists = favorites.any((fav) => fav.id == item.id);
  
  if (!exists) {
    favorites.add(item);
    await saveFavorites(favorites);
  }
}

  // アイテムを削除
  static Future<void> removeFavorite(String id) async {
    final favorites = await loadFavorites();
    favorites.removeWhere((item) => item.id == id);
    await saveFavorites(favorites);
  }
}
