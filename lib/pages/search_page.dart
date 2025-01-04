import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import '../widgets/search_form.dart';
import '../utils/data_helper.dart';

/// 🔍 検索画面
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
    final data = await loadJsonData('assets/data/sample_data.json');
    setState(() {
      _data = data;
      _filteredData = data;
    });
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
    _debounce = onConditionChanged(() {
      setState(() {
        _filterData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('条件検索')),
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
                            color: hasWebsite ? Colors.blue : Colors.grey,
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
