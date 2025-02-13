import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fishing_app/providers/favorites_provider.dart';
import 'package:fishing_app/pages/home_initial.dart';
import 'package:fishing_app/screens/my_list_screen.dart';
import 'package:fishing_app/screens/my_list_reorder_screen.dart'; // 🔹 追加

class BottomNav extends StatelessWidget {
  final int currentIndex;

  const BottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x1AD9D9D9), // 塗り：D9D9D9 不透明度10%
        border: Border(
          top: BorderSide(
            color: const Color(0x1AD9D9D9), // 塗り：D9D9D9 不透明度10%
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '検索',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'マイリスト',
            ),
          ],
          onTap: (index) {
            if (index != currentIndex) {
              switch (index) {
                case 0:
                  final favoritesProvider =
                      Provider.of<FavoritesProvider>(context, listen: false);
                  if (favoritesProvider.favorites.isNotEmpty) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyListScreen(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeInitialScreen(),
                      ),
                    );
                  }
                  break;
                case 1:
                  Navigator.pushNamed(context, '/search');
                  break;
                case 2:
                  // 🔹 マイリスト → 並び替え画面へ遷移
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyListReorderScreen(),
                    ),
                  );
                  break;
              }
            }
          },
        ),
      ),
    );
  }
}
