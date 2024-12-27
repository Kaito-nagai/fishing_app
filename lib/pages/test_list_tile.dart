import 'package:flutter/material.dart';

class TestListTilePage extends StatefulWidget {
  const TestListTilePage({super.key}); 

  @override
  _TestListTilePageState createState() => _TestListTilePageState();
}


class _TestListTilePageState extends State<TestListTilePage> {
  bool isFavorite = false; // お気に入り状態を管理

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite; // 状態をトグル
    });
    print('♡ボタンが押されました');
    print('isFavoriteの状態: $isFavorite');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListTile 単体テスト'),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          child: ListTile(
            title: Text('テスト業者'),
            subtitle: Text('公式HPあり'),
            trailing: GestureDetector(
              onTap: _toggleFavorite, // お気に入り状態の切り替え
              child: Container(
                color: Colors.transparent, // タップ領域を確保
                padding: EdgeInsets.all(8.0), // 余白を確保
                child: Text(
                  isFavorite ? '♡（お気に入り）' : '♡',
                  style: TextStyle(
                    color: isFavorite ? Colors.green : Colors.red,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

