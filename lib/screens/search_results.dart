import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../components/vendor_list.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/search_bar.dart';
import '../providers/favorites_provider.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
  }

  void _onSearchSubmitted(String query) {
    _logger.d('再検索: $query');
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

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

            // 検索結果リスト
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
                    : VendorList(
                        vendors: widget.searchResults,
                        favoritesProvider: favoritesProvider,
                        navigateToMyListScreen: false, // 即座に遷移しない
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
