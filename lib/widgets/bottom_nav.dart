import 'package:flutter/material.dart';

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
            color: const Color(0x1AD9D9D9), // 塗り：D9D9D9 不透明度10
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // 完全透明に変更
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex, // ここを変更
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
                  Navigator.pushNamed(context, '/');
                  break;
                case 1:
                  Navigator.pushNamed(context, '/search');
                  break;
                case 2:
                  debugPrint('マイリストがタップされました');
                  break;
              }
            }
          },
        ),
      ),
    );
  }
}
