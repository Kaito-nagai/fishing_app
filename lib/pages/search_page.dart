import 'package:flutter/material.dart';
import 'package:fishing_app/models/favorite_manager.dart';
import 'package:fishing_app/models/favorite_item.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fishing_app/pages/search_form.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // 🔍 検索条件用コントローラー
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final List<bool> _selectedPrices = List.generate(20, (index) => false);

  // 📊 データ管理
  List<dynamic> _data = [];
  List<dynamic> _filteredData = [];
  Timer? _debounce;

  // ❤️ お気に入り管理
  Set<String> _favoriteIds = {};

  @override
void initState() {
  super.initState();
  _loadJsonData(); // JSONデータをロード
  _loadFavorites(); // お気に入りデータをロード
}

  @override
  void dispose() {
    _debounce?.cancel();
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // 📥 JSONデータをロード
  Future<void> _loadJsonData() async {
  try {
    debugPrint('📥 JSONデータの読み込みを開始します...'); // 開始メッセージ

    final String response = await rootBundle.loadString('assets/data/sample_data.json');
    debugPrint('✅ JSONファイルの内容: $response'); // JSONの生データを表示

    final data = json.decode(response);
    debugPrint('✅ デコード後のデータ: $data'); // デコード後のデータを表示

    setState(() {
      _data = data;
      _filteredData = data;
      debugPrint('✅ _dataに格納されたデータ: $_data'); // _dataの内容を表示
      debugPrint('✅ _filteredDataに格納されたデータ: $_filteredData'); // _filteredDataの内容を表示
    });
  } catch (e) {
    debugPrint('❌ JSONデータの読み込みに失敗しました: $e');
  }
}


  // ❤️ お気に入りデータをロード
  Future<void> _loadFavorites() async {
    final favorites = await FavoriteManager.loadFavorites();
    setState(() {
      _favoriteIds = favorites.map((item) => item.id).toSet();
    });
  }

  Future<void> _toggleFavorite(dynamic item) async {
  final id = item['id'];
  setState(() {
    if (_favoriteIds.contains(id)) {
      // お気に入りから削除
      FavoriteManager.removeFavorite(id);
      _favoriteIds.remove(id);
    } else {
      // お気に入りに追加
      final favoriteItem = FavoriteItem(
        id: id,
        name: item['name'],
        link: item['link'],
      );
      FavoriteManager.addFavorite(favoriteItem);
      _favoriteIds.add(id);
    }
  });

  // 保存を確認
  await FavoriteManager.saveFavorites(
    _favoriteIds.map((id) {
      final item = _data.firstWhere((element) => element['id'] == id);
      return FavoriteItem(
        id: id,
        name: item['name'],
        link: item['link'],
      );
    }).toList(),
  );
}

  // 🔍 データをフィルタリング
  void _filterData() {
    setState(() {
      _filteredData = _data.where((item) {
        final String name = item['name'];
        final String location = item['location'];
        final int price = item['price'];

        final bool matchesName =
            _nameController.text.isEmpty || name.contains(_nameController.text);

        final bool matchesLocation =
            _locationController.text.isEmpty || location.contains(_locationController.text);

        final bool matchesPrice = _selectedPrices.asMap().entries.any((entry) {
          if (entry.value) {
            final int minPrice = entry.key * 1000;
            final int maxPrice = (entry.key + 1) * 1000;
            return price >= minPrice && price < maxPrice;
          }
          return false;
        });

        return matchesName && matchesLocation && matchesPrice;
      }).toList();
    });
  }

// 🔄 検索条件が変更されたときの処理
  void _onConditionChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), _filterData);
  }

  void _showSnackBar(String message, Color backgroundColor) {
  if (!mounted) return; // BuildContextが無効なら何もしない

  final messenger = ScaffoldMessenger.of(context); // 事前に取得

  messenger.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('条件検索'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 検索フォーム
              SearchForm(
                nameController: _nameController,
                locationController: _locationController,
                onConditionChanged: _onConditionChanged,
              ),
              const SizedBox(height: 16),

              // 💰 料金範囲チェックボックス
              const Text('💰 料金範囲', style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: _selectedPrices.length,
                  itemBuilder: (context, index) {
                    final int minPrice = index * 1000;
                    final int maxPrice = (index + 1) * 1000;
                    return CheckboxListTile(
                      title: Text('$minPrice 〜 $maxPrice 円'),
                      value: _selectedPrices[index],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedPrices[index] = value ?? false;
                        });
                        _onConditionChanged();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // 🔄 リセットボタン
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _nameController.clear();
                    _locationController.clear();
                    _selectedPrices.fillRange(0, _selectedPrices.length, false);
                    _filteredData = _data;
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('リセット'),
              ),
              const SizedBox(height: 16),

              // 🔔 Snackbarを安全に表示するメソッド



// // 📋 検索結果リスト
_filteredData.isEmpty
    ? const Center(child: Text('❌ 一致する条件がありません'))
    : ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _filteredData.length,
        itemBuilder: (context, index) {
          final item = _filteredData[index];
          final bool isFavorite = _favoriteIds.contains(item['id']);
          final bool hasWebsite = item['link'] != null && item['link'].isNotEmpty;

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: hasWebsite ? Colors.blue : Colors.grey,
            child: ListTile(
              title: Text(
                item['name'],
                style: TextStyle(
                  color: hasWebsite ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                hasWebsite ? '公式HPあり' : '公式HPなし',
                style: TextStyle(
                  color: hasWebsite ? Colors.white70 : Colors.black54,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  _toggleFavorite(item); // お気に入りの追加・削除を切り替え
                },
              ),
              onTap: () async {
                if (hasWebsite) {
                  final Uri url = Uri.parse(item['link']);
                  try {
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      if (!mounted) return;
                      _showSnackBar('❌ リンクを開けませんでした: ${item['link']}', Colors.red);
                    }
                  } catch (e) {
                    if (!mounted) return;
                    _showSnackBar('❌ エラーが発生しました: $e', Colors.red);
                  }
                } else {
                  if (!mounted) return;
                  _showSnackBar('❌ 公式HPが存在しません', Colors.grey);
                }
              },
            ),
          );
        },
      )



            ],
          ),
        ),
      ),
    );
  }
}
