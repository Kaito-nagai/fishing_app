import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'pages/splash_screen.dart'; // SplashScreenをインポート

void main() {
  runApp(const FishingApp());
}

// アプリ全体のエントリーポイント
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
      home: const SplashScreen(), // ホーム画面を指定
    );
  }
}
