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
  SearchResultsState createState() => SearchResultsState(); // クラス名修正済み
}

class SearchResultsState extends State<SearchResults> {
  late TextEditingController _searchController;
  final Logger _logger = Logger(); // Logger インスタンス

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
  }

  void _onSearchSubmitted(String query) {
    _logger.d('再検索: $query'); // print を logger に置き換え
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
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0), // 左寄せ調整
              child: Align(
                alignment: Alignment.centerLeft, // テキストを左寄せ
                child: Text(
                  '検索結果',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),


            // 検索結果リスト (統一した `VendorList` を使用)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.1, vertical: 1.5),
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
                    : VendorList(vendors: widget.searchResults),
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
