import 'package:flutter/material.dart';
import 'package:fishing_app/components/vendor_list.dart';
import 'package:fishing_app/models/favorite_manager.dart';

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // FavoriteManagerを初期化
    final favoriteManager = FavoriteManager();
    favoriteManager.loadFavorites(); // お気に入りデータをロード

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // 上部広告エリア
          Container(
            width: screenWidth,
            height: screenHeight * 0.1,
            color: Colors.white.withAlpha(153), 
            child: const Center(
              child: Text(
                '広告エリア',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // マイリストタイトル
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'マイリスト',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // お気に入り業者リスト
          Expanded(
            child: favoriteManager.favorites.isEmpty
                ? const Center(
                    child: Text(
                      'お気に入りに登録された業者はありません。',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : VendorList(
                    vendors: favoriteManager.favorites.map((favorite) => Vendor(
                      id: favorite.id,
                      title: favorite.name,
                      location: '', // 必要なら location を適切に設定
                      imagePath: 'assets/images/placeholder_image.png', // 仮の画像パスを使用
                     )).toList(),
                    favoriteManager: favoriteManager, // FavoriteManagerを渡す
                  ),
          ),
        ],
      ),
    );
  }
}
