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

    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);

    // 🔹 検索結果画面では自動遷移しない
    if (favoritesProvider.favorites.isEmpty && ModalRoute.of(context)?.settings.name != '/search_results') {
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
            AdBanner(
              positionTop: 0.02,
              onTap: () => logger.i('広告がタップされました'),
            ),
            const SizedBox(height: 20),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: VendorList(
                  vendors: favoriteItems.map((favorite) => Vendor(
                    id: favorite['id'],
                    title: favorite['name'],
                    location: favorite['location'] ?? '',
                    imagePath: 'assets/images/placeholder_image.png',
                    catchInfo: favorite['catchInfo'] ?? '',
                  )).toList(),
                  favoritesProvider: favoritesProvider,
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
