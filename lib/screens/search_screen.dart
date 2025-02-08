import 'package:flutter/material.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';
import 'package:fishing_app/utils/json_loader.dart';
import 'package:fishing_app/components/vendor_list.dart';
import 'package:fishing_app/screens/search_results.dart'; // 検索結果画面をインポート

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List<Vendor> allVendors = [];
  List<Vendor> filteredVendors = [];

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
        builder: (context) => SearchResults(searchResults: results),
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
            // 検索バーと戻るアイコン
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 16, top: 8, bottom: 8),
              child: Row(
                children: [
                  // 戻るアイコン
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    iconSize: 24,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  // 検索バー
                  Expanded(
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF424242),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        onSubmitted: _onSearchSubmitted,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: '業者名、場所などで検索',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
