import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';


/// お気に入りの状態を更新する関数
Future<void> updateFavorite(String id, {VoidCallback? onFavoritesUpdated}) async {
  try {
    // SharedPreferences インスタンスの取得
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteList = prefs.getStringList('favorite_list') ?? [];

    // IDをもとに追加または削除
    bool isRemoved = false;
    favoriteList.removeWhere((item) {
      final decodedItem = jsonDecode(item) as Map<String, dynamic>;
      if (decodedItem['id'] == id) {
        isRemoved = true;
        return true; // 削除対象を指定
      }
      return false;
    });

    // 削除されていない場合、新しいアイテムを追加
    if (!isRemoved) {
      favoriteList.add(jsonEncode({
        'id': id,
        'name': '渡船名', // 動的データを渡す
        'link': 'https://example.com' // 実際のリンクを渡す
      }));
      if (kDebugMode) debugPrint('❤️ Added to favorites: $id');
    } else {
      if (kDebugMode) debugPrint('🗑️ Removed from favorites: $id');
    }

    // 更新されたリストを保存
    await prefs.setStringList('favorite_list', favoriteList);

    // デバッグログ
    if (kDebugMode) {
      debugPrint('✅ お気に入りリストを更新: $favoriteList');
    }

    // UI更新コールバックを呼び出し
    if (onFavoritesUpdated != null) {
      onFavoritesUpdated();
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('❌ お気に入りリストの更新中にエラーが発生: $e');
    }
  }
}
