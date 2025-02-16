import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:fishing_app/components/vendor_list.dart';
import 'package:fishing_app/providers/favorites_provider.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';
import 'package:fishing_app/widgets/ad_banner.dart';
import 'package:fishing_app/pages/home_initial.dart';

final logger = Logger();

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // お気に入りリストを取得
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);

    // 🔹 お気に入りが空なら即座に home_initial.dart に戻る
    if (favoritesProvider.favorites.isEmpty) {
      logger.i('お気に入りが空になったため、ホーム画面に戻ります');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeInitialScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final favoriteItems = favoritesProvider.favorites;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 広告エリア
            AdBanner(
              positionTop: 0.02, // 画面の上部に配置
              onTap: () => logger.i('広告がタップされました'),
            ),

            const SizedBox(height: 20), // 広告エリアの高さ分の余白を追加

            // マイリストタイトル
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0), // 広告との間にスペースを確保
                child: VendorList(
                  vendors: favoriteItems.map((favorite) => Vendor(
                    id: favorite['id'], // Map型なのでキーで取得
                    title: favorite['name'],
                    location: favorite['location'] ?? '', // 必要なら location を適切に設定
                    imagePath: 'assets/images/placeholder_image.png', // 仮の画像パスを使用
                    catchInfo: favorite['catchInfo'] ?? '', // 🔹 追加
                  )).toList(),
                  favoritesProvider: favoritesProvider, // 必要なプロバイダーを渡す
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
}
