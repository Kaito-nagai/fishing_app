import 'package:fishing_app/pages/search_form.dart'; // SearchFormをインポート
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final List<bool> _selectedPrices = List.generate(20, (index) => false);

  List<dynamic> _filteredData = [];

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _onConditionChanged() {
    setState(() {
      debugPrint('🔄 _onConditionChanged called');
      // ここに条件変更時のフィルタ処理を追加
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🏗️ Building SearchPage...');
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
              // 🛠️ SearchForm のデバッグ用テキストを追加
              const Text(
                '🛠️ Debug: SearchFormウィジェットを表示',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
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
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _nameController.clear();
                    _locationController.clear();
                    _selectedPrices.fillRange(0, _selectedPrices.length, false);
                    _filteredData = [];
                  });
                  debugPrint('🔄 Filters reset');
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
                            final Uri url = Uri.parse(item['link']);
                            final bool canLaunch = await canLaunchUrl(url);
                            if (canLaunch) {
                              await launchUrl(url,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              debugPrint('❌ Could not launch $url');
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
