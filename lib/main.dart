import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // providerパッケージをインポート
import 'providers/favorites_provider.dart'; // FavoritesProviderをインポート
import 'pages/home_initial.dart'; // HomeInitialScreenをインポート

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()), // 初期化済みプロバイダを登録
      ],
      child: const FishingApp(),
    ),
  );
}

// アプリ全体のエントリーポイント
class FishingApp extends StatelessWidget {
  const FishingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fishing App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeInitialScreen(), // 初期画面をHomeInitialScreenに変更
    );
  }
}
