import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

/// お気に入りの状態を更新する関数
Future<void> updateFavorite(String id) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> favoriteList = prefs.getStringList('favorite_list') ?? [];

  if (favoriteList.contains(id)) {
    favoriteList.remove(id); // お気に入りから削除
  } else {
    favoriteList.add(id); // お気に入りに追加
  }

  await prefs.setStringList('favorite_list', favoriteList);

  if (kDebugMode) {
    debugPrint('✅ お気に入りリストを更新: $favoriteList');
  }
}
