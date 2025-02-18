import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../components/vendor_list.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/search_bar.dart';
import '../providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import '../utils/json_loader.dart'; // 🔹 JSONデータ読み込み用

class SearchResults extends StatefulWidget {
  final List<Vendor> searchResults;
  final String initialQuery;

  const SearchResults({
    super.key,
    required this.searchResults,
    required this.initialQuery,
  });

  @override
  SearchResultsState createState() => SearchResultsState();
}

class SearchResultsState extends State<SearchResults> {
  late TextEditingController _searchController;
  final Logger _logger = Logger();
  List<Vendor> _displayedResults = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    _displayedResults = widget.searchResults;
  }

  // 🔹 再検索を実行する処理
  void _onSearchSubmitted(String query) async {
    if (query.isEmpty) return;

    _logger.d('再検索: $query');

    // 🔹 JSONデータを再読み込みして検索
    List<Vendor> allVendors = await loadVendorsFromJson();
    List<Vendor> results = allVendors.where((vendor) {
      final title = vendor.title.toLowerCase();
      final location = vendor.location.toLowerCase();
      return title.contains(query.toLowerCase()) || location.contains(query.toLowerCase());
    }).toList();

    // 🔹 検索結果を更新
    setState(() {
      _displayedResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 再検索可能な検索バー
            SearchBarWithBackButton(
              onBackPressed: () {
                Navigator.pop(context);
              },
              onSubmitted: _onSearchSubmitted,
              searchController: _searchController,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.1, vertical: 1.5),
                child: _displayedResults.isEmpty
                    ? const Center(
                        child: Text(
                          '該当する結果が見つかりません',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : VendorList(
                        vendors: _displayedResults,
                        favoritesProvider: favoritesProvider,
                        navigateToMyListScreen: false,
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(currentIndex: 1),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
