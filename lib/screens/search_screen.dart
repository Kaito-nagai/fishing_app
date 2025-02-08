import 'package:flutter/material.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';
import 'package:fishing_app/utils/json_loader.dart';
import 'package:fishing_app/components/vendor_list.dart';
import 'package:fishing_app/screens/search_results.dart'; // 検索結果画面をインポート
import 'package:fishing_app/widgets/search_bar.dart'; // SearchBarWithBackButtonをインポート

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List<Vendor> allVendors = [];
  List<Vendor> filteredVendors = [];
  final TextEditingController _searchController = TextEditingController(); // 検索コントローラを追加


  @override
  void initState() {
    super.initState();
    _loadVendors();
  }

  Future<void> _loadVendors() async {
    List<Vendor> vendors = await loadVendorsFromJson();
    setState(() {
      allVendors = vendors;
    });
  }

  void _onSearchSubmitted(String query) {
    List<Vendor> results = allVendors
        .where((vendor) =>
            vendor.title.toLowerCase().contains(query.toLowerCase()) ||
            vendor.location.toLowerCase().contains(query.toLowerCase()))
        .toList();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchResults(
        searchResults: results,
        initialQuery: query, // 必須パラメータを追加
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 修正後の検索バーと戻るボタン
            SearchBarWithBackButton(
              onBackPressed: () {
                Navigator.pop(context);
              },
              onSubmitted: _onSearchSubmitted,
              searchController: _searchController, // 必須パラメータとして渡す
            ),

            // 広告エリア
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(153),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    '広告エリア',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),

            // おすすめリストタイトル
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'おすすめの渡船や遊漁船',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 業者リストの表示
            Expanded(
              child: allVendors.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : VendorList(vendors: allVendors),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}
