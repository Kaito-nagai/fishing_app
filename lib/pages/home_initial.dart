import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';
import 'package:fishing_app/widgets/label_text_widget.dart';
import 'package:fishing_app/widgets/ad_banner.dart';
import 'package:fishing_app/components/vendor_list.dart';
import 'package:fishing_app/utils/json_loader.dart'; // loadVendorsFromJson をインポート
import 'package:provider/provider.dart'; // Provider パッケージをインポート
import 'package:fishing_app/providers/favorites_provider.dart'; // FavoritesProvider をインポート
import 'package:fishing_app/screens/my_list_screen.dart'; // MyListScreen をインポート

// グローバルスコープで Logger を初期化
final logger = Logger();

class HomeInitialScreen extends StatelessWidget {
  const HomeInitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // FavoritesProvider を使用してお気に入りリストを取得
    final favoritesProvider = context.watch<FavoritesProvider>();

    // 🔹 お気に入りがある場合、自動的にMyListScreenへ遷移するよう修正
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (favoritesProvider.favorites.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyListScreen()),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0), // ダークモードの背景色を指定
      body: Stack(
        children: [
          Positioned(
            left: screenWidth * 0,
            top: screenHeight * 0.240,
            child: SizedBox(
              width: screenWidth * 1,
              height: screenHeight * 0.66, // 全体の高さを制限
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 上部テキスト
                  LabelTextWidget(
                    text: 'マイリストに業者を登録しよう',
                    fontSize: 0.06,
                    positionTop: 0,
                    positionLeft: 0.02,
                    width: 1.5,
                    height: 0.05,
                  ),
                  LabelTextWidget(
                    text: 'まだ未登録の状態です',
                    fontSize: 0.045,
                    positionTop: 0,
                    positionLeft: 0.02,
                    width: 0.98,
                    height: 0.030,
                  ),
                  const SizedBox(height: 8.0), // テキストとリストの間の余白を調整

                  // 業者リスト（スクロール可能）
                  Expanded(
                    child: FutureBuilder<List<Vendor>>(
                      future: loadVendorsFromJson(), // JSON データを読み込む
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator()); // ローディング表示
                        } else if (snapshot.hasError) {
                          return Text('エラー: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return VendorList(
                            vendors: snapshot.data!, // 業者リスト
                            favoritesProvider: favoritesProvider, // 修正: FavoritesProviderを渡す
                          );
                        } else {
                          return const Text('データが見つかりません');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          AdBanner(
            positionTop: 0.090,
            onTap: () => logger.i('上部の広告クリック'),
          ),
          Positioned(
            left: screenWidth * 0.48,
            top: screenHeight * -0.045,
            child: Container(
              width: screenWidth * 0.25,
              height: screenHeight * 0.12,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
}
