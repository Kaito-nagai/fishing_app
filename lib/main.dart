import 'dart:async'; // Debounce用
import 'dart:math'; // ランダム用
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart'; // 外部リンク用
import 'package:flutter/foundation.dart'; // kDebugMode用
import 'package:fishing_app/pages/search_form.dart'; // SearchFormをインポート

void main() {
  if (kDebugMode) {
    debugPrint('Starting FishingApp...');
  }
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
      home: const HomePage(), // ホーム画面を指定
    );
  }
}

// ホーム画面
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      debugPrint('Building HomePage...');
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Fishing App')),
      body: const Center(child: Text('ようこそ！', style: TextStyle(fontSize: 24))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (kDebugMode) {
            debugPrint('FloatingActionButton pressed');
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchPage()),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}

// 検索画面
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final List<bool> _selectedPrices = List.generate(20, (index) => false);

  List<dynamic> _data = [];
  List<dynamic> _filteredData = [];
  Timer? _debounce; // 入力遅延用のタイマー

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      debugPrint('SearchPage: initState is called');
    }
    _loadJsonData();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // JSONデータをロード
  Future<void> _loadJsonData() async {
    try {
      if (kDebugMode) {
        debugPrint('SearchPage: Loading JSON data...');
      }
      final String response = await rootBundle.loadString(
        'assets/data/sample_data.json',
      );
      final data = json.decode(response);
      setState(() {
        _data = data;
        _filteredData = data; // 初期状態で全データを表示
      });
      if (kDebugMode) {
        debugPrint('SearchPage: JSON data loaded.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading JSON data: $e');
      }
    }
  }

  // 入力条件が変更されたときに呼び出される
  void _onConditionChanged() {
    if (kDebugMode) {
      debugPrint('_onConditionChanged called');
    }
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _filterData();
    });
  }

  // 条件に基づいてデータをフィルタリング
  void _filterData() {
    setState(() {
      if (_nameController.text.isEmpty &&
          _locationController.text.isEmpty &&
          !_selectedPrices.contains(true)) {
        _filteredData = _getRandomData(); // 条件が空の場合、ランダムデータを表示
      } else {
        _filteredData =
            _data.where((item) {
              final String name = item['name'];
              final String location = item['location'];
              final int price = item['price'];

              final bool matchesName =
                  _nameController.text.isEmpty ||
                  name.contains(_nameController.text);

              final bool matchesLocation =
                  _locationController.text.isEmpty ||
                  location.contains(_locationController.text);

              final bool matchesPrice = _selectedPrices.asMap().entries.any((
                entry,
              ) {
                if (entry.value) {
                  final int minPrice = entry.key * 1000;
                  final int maxPrice = (entry.key + 1) * 1000;
                  return price >= minPrice && price < maxPrice;
                }
                return false;
              });

              return matchesName && matchesLocation && matchesPrice;
            }).toList();
      }
    });
  }

  // ランダムにデータを取得
  List<dynamic> _getRandomData() {
    final random = Random();
    final randomData = <dynamic>[];

    for (int i = 0; i < 5 && _data.isNotEmpty; i++) {
      randomData.add(_data[random.nextInt(_data.length)]);
    }
    return randomData;
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      debugPrint('Building SearchPage...');
    }
    return Scaffold(
      appBar: AppBar(title: const Text('条件検索')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // 全体をスクロール可能に
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchForm(
                nameController: _nameController,
                locationController: _locationController,
                onConditionChanged: _onConditionChanged,
              ),
              const SizedBox(height: 16),
              const Text('料金範囲', style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 300, // 高さを明示的に指定
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
              TextButton(
                onPressed: () {
                  setState(() {
                    _nameController.clear();
                    _locationController.clear();
                    _selectedPrices.fillRange(0, _selectedPrices.length, false);
                    _filteredData = _data;
                  });
                },
                child: const Text('リセット'),
              ),
              const Text('検索結果', style: TextStyle(fontSize: 18)),
              _filteredData.isEmpty
                  ? const Center(
                    child: Text(
                      '一致する条件がありません',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                  : ListView.builder(
                    shrinkWrap: true, // ListViewの高さを内容に合わせる
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredData.length,
                    itemBuilder: (context, index) {
                      final item = _filteredData[index];
                      final bool hasWebsite =
                          item['link'] != null && item['link'].isNotEmpty;

                      return GestureDetector(
                        onTap: () async {
                          if (hasWebsite) {
                            final Uri url = Uri.parse(item['link']);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          }
                        },
                        child: Card(
                          color: hasWebsite ? Colors.blue : Colors.grey,
                          child: ListTile(
                            title: Text(item['name']),
                            subtitle: Text(
                              hasWebsite ? '公式HPあり' : '公式HPなし',
                              style: TextStyle(
                                color: hasWebsite ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
