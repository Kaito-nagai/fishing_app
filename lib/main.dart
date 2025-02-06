import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favorites_provider.dart';
import 'pages/home_initial.dart';
import 'screens/search_screen.dart'; // 検索画面をインポート
import 'package:flutter/foundation.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          if (kDebugMode) {
            debugPrint('FavoritesProvider initialized');
          }
          return FavoritesProvider();
        }),
      ],
      child: const FishingApp(),
    ),
  );
}

class FishingApp extends StatelessWidget {
  const FishingApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      debugPrint('FishingApp: Building...');
    }
    return MaterialApp(
      title: 'Fishing App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // 初期ルート
      routes: {
        '/': (context) {
          if (kDebugMode) {
            debugPrint('Navigating to HomeInitialScreen');
          }
          return const HomeInitialScreen();
        },
        '/search': (context) {
          if (kDebugMode) {
            debugPrint('Navigating to SearchScreen');
          }
          return const SearchScreen(); // 検索画面を登録
        },
      },
    );
  }
}
