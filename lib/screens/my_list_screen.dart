import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fishing_app/components/vendor_list.dart';
import 'package:fishing_app/providers/favorites_provider.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';
import 'package:fishing_app/widgets/search_bar.dart';

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 検索バー用のコントローラーを初期化
    final TextEditingController searchController = TextEditingController();

    // Providerからお気に入りリストを取得
    final favoritesProvider = context.watch<FavoritesProvider>();
    final favoriteItems = favoritesProvider.favorites;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 検索バー
            SearchBarWithBackButton(
              onBackPressed: () {
                Navigator.pop(context);
              },
              onSubmitted: (query) {
                // 検索機能の実装
              },
              searchController: searchController, // 修正: 必須パラメータを追加
            ),
            const SizedBox(height: 10),

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
              child: favoriteItems.isEmpty
                  ? const Center(
                      child: Text(
                        'お気に入りに登録された業者はありません。',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : VendorList(
                      vendors: favoriteItems.map((favorite) => Vendor(
                        id: favorite['id'], // Map型なのでキーで取得
                        title: favorite['name'],
                        location: '', // 必要なら location を適切に設定
                        imagePath: 'assets/images/placeholder_image.png', // 仮の画像パスを使用
                      )).toList(),
                      favoritesProvider: favoritesProvider, // 必要なプロバイダーを渡す
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
