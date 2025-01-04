import 'package:shared_preferences/shared_preferences.dart';
import 'favorite_item.dart';
import 'package:logger/logger.dart';


class FavoriteManager {
  List<FavoriteItem> favorites = [];

  /// お気に入りデータをロード
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favorite_list') ?? [];
    favorites = favoriteList.map((id) {
      return FavoriteItem(
        id: id,
        name: 'お気に入り業者 $id',
        link: 'https://example.com/$id',
      );
    }).toList();
    final Logger logger = Logger();
logger.d('お気に入りリストのデータをロードしました');
  }

  /// お気に入りを追加・削除
  void toggleFavorite(FavoriteItem item) {
    final Logger logger = Logger();
    if (favorites.any((fav) => fav.id == item.id)) {
      favorites.removeWhere((fav) => fav.id == item.id);
      logger.i('🗑️ お気に入りから削除: ${item.id}');
    } else {
      favorites.add(item);
      logger.i('⭐ お気に入りに追加: ${item.id}');
    }
    saveFavorites();
  }

  /// お気に入りデータを保存
  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = favorites.map((item) => item.id).toList();
    await prefs.setStringList('favorite_list', favoriteList);
    final Logger logger = Logger();
    logger.i('お気に入りデータの保存が完了しました');
  }

  /// お気に入りリストを取得
  List<FavoriteItem> getFavorites() {
    return favorites;
  }
}
