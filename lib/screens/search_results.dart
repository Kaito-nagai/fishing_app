import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // Logger ライブラリをインポート
import '../components/vendor_list.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/search_bar.dart';

class SearchResults extends StatefulWidget {
  final List<Vendor> searchResults;
  final String initialQuery;

  const SearchResults({
    super.key,
    required this.searchResults,
    required this.initialQuery,
  });

  @override
  SearchResultsState createState() => SearchResultsState(); // 修正: クラス名からアンダースコアを削除
}

class SearchResultsState extends State<SearchResults> { // 修正: クラス名からアンダースコアを削除
  late TextEditingController _searchController;
  final Logger _logger = Logger(); // Logger インスタンスを作成


  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
  }

  void _onSearchSubmitted(String query) {
    // 再検索ロジック
    _logger.d('再検索: $query'); // print を logger.d に置き換え
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 検索バー
            SearchBarWithBackButton(
              onBackPressed: () {
                Navigator.pop(context);
              },
              onSubmitted: _onSearchSubmitted,
              searchController: _searchController,
            ),

            // 検索結果タイトル
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '検索結果',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 検索結果リスト
            Expanded(
              child: widget.searchResults.isEmpty
                  ? const Center(
                      child: Text(
                        '該当する結果が見つかりません',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.searchResults.length,
                      itemBuilder: (context, index) {
                        final vendor = widget.searchResults[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Card(
                            color: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  vendor.imagePath,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                vendor.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                vendor.location,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.favorite_border, color: Colors.white),
                                onPressed: () {
                                  // お気に入りボタンの処理
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
