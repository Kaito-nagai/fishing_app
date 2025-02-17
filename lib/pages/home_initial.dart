import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';
import 'package:fishing_app/widgets/label_text_widget.dart';
import 'package:fishing_app/widgets/ad_banner.dart';
import 'package:fishing_app/components/vendor_list.dart';
import 'package:fishing_app/utils/json_loader.dart';
import 'package:provider/provider.dart';
import 'package:fishing_app/providers/favorites_provider.dart';
import 'package:fishing_app/screens/my_list_screen.dart';

final logger = Logger();

class HomeInitialScreen extends StatelessWidget {
  const HomeInitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final favoritesProvider = context.watch<FavoritesProvider>();

    // 🔹 検索結果画面からは自動遷移しない
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (favoritesProvider.favorites.isNotEmpty && ModalRoute.of(context)?.settings.name != '/search_results') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyListScreen()),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          Positioned(
            left: screenWidth * 0,
            top: screenHeight * 0.240,
            child: SizedBox(
              width: screenWidth * 1,
              height: screenHeight * 0.66,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: FutureBuilder<List<Vendor>>(
                      future: loadVendorsFromJson(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('エラー: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return VendorList(
                            vendors: snapshot.data!,
                            favoritesProvider: favoritesProvider,
                            navigateToMyListScreen: true, 
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
