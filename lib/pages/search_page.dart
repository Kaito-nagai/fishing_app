import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import '../widgets/search_form.dart';
import '../utils/data_helper.dart';
import '../widgets/favorite_button.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// FavoriteItem のパスを調整

class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteItems;

  const SearchPage({
    super.key,
    required this.favoriteItems,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final List<bool> _selectedPrices = List.generate(20, (index) => false);
  List<dynamic> _data = [];
  List<dynamic> _filteredData = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadJsonData();
    if (kDebugMode) {
      debugPrint('SearchPage: initState is called');
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  /// JSONデータをロード
  void _loadJsonData() async {
    try {
      final List<dynamic> data =
          await loadJsonData('assets/data/sample_data.json');
      debugPrint('✅ Data Type: ${data.runtimeType}');

      setState(() {
        _data = data
            .where((item) =>
                item is Map<String, dynamic> &&
                item['id'] != null &&
                item['name'] != null &&
                item['link'] != null)
            .map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item))
            .toList();
        _filteredData = _data;
      });

      debugPrint('✅ Loaded Data: $_data');
    } catch (e) {
      debugPrint('❌ Error loading JSON data: $e');
    }
  }

  /// ランダムデータを取得
  void _getRandomData() {
    setState(() {
      _filteredData = getRandomData(_data);
    });
  }

  /// データをフィルタリング
  void _filterData() {
    setState(() {
      if (_nameController.text.isEmpty &&
          _locationController.text.isEmpty &&
          !_selectedPrices.contains(true)) {
        _getRandomData();
        return;
      }

      _filteredData = filterData(
        data: _data,
        nameFilter: _nameController.text,
        locationFilter: _locationController.text,
        selectedPrices: _selectedPrices,
      );
    });
  }

  /// 入力条件変更時のディレイ処理
  void _onConditionChanged() {
    if (kDebugMode) {
      debugPrint('_onConditionChanged called');
    }
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _filterData();
      });
    });
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
              SearchForm(
                nameController: _nameController,
                locationController: _locationController,
                onConditionChanged: _onConditionChanged,
              ),
              const SizedBox(height: 16),
              const Text('料金範囲', style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    if (index < 15) {
                      final int minPrice = index * 1000;
                      final int maxPrice = (index + 1) * 1000;
                      return CheckboxListTile(
                        title: Text('$minPrice ~ $maxPrice 円'),
                        value: _selectedPrices[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedPrices[index] = value ?? false;
                          });
                          _onConditionChanged();
                        },
                      );
                    } else {
                      return CheckboxListTile(
                        title: const Text('15000 円以上'),
                        value: _selectedPrices[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedPrices[index] = value ?? false;
                          });
                          _onConditionChanged();
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text('検索結果', style: TextStyle(fontSize: 18)),
              _filteredData.isEmpty
                  ? const Center(
                      child: Text(
                        '一致する条件がありません',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
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
                            color:
                                hasWebsite ? Colors.blue : Colors.grey.shade300,
                            child: ListTile(
                              title: Text(item['name']),
                              subtitle: Text(
                                hasWebsite ? '公式HPあり' : '公式HPなし',
                                style: TextStyle(
                                  color: hasWebsite
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FavoriteButton(
                                    favoriteKey: item['id'] ?? '',
                                    initialIsFavorite: widget.favoriteItems.any(
                                      (fav) => fav['id'] == item['id'],
                                    ),
                                    onFavoriteUpdated: () async {
                                      setState(() {
                                        final isAlreadyFavorite =
                                            widget.favoriteItems.any(
                                                (fav) => fav['id'] == item['id']);

                                        if (isAlreadyFavorite) {
                                          widget.favoriteItems.removeWhere(
                                              (fav) => fav['id'] == item['id']);
                                        } else {
                                          widget.favoriteItems.add({
                                            'id': item['id'].toString(),
                                            'name': item['name'].toString(),
                                            'link': item['link'].toString(),
                                          });
                                        }
                                      });
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.setString(
                                        'favorite_list',
                                        jsonEncode(widget.favoriteItems),
                                      );
                                      debugPrint(
                                          '✅ Favorites saved to SharedPreferences');
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.link,
                                        color: Colors.blue),
                                    onPressed: () async {
                                      if (hasWebsite) {
                                        final Uri url = Uri.parse(item['link']);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url);
                                        }
                                      }
                                    },
                                  ),
                                ],
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
