import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';
import 'package:fishing_app/utils/json_loader.dart';
import 'package:fishing_app/components/vendor_list.dart';
import 'package:fishing_app/screens/search_results.dart';
import 'package:fishing_app/widgets/search_bar.dart';
import 'package:fishing_app/providers/favorites_provider.dart';
import 'package:fishing_app/widgets/ad_banner.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List<Vendor> allVendors = [];
  final TextEditingController _searchController = TextEditingController();

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
          initialQuery: query,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWithBackButton(
              onBackPressed: () {
                Navigator.pop(context);
              },
              onSubmitted: _onSearchSubmitted,
              searchController: _searchController,
            ),

            // 広告エリアを中央に配置
            Center(
              child: AdBanner(
                positionTop: 0.02, // 適宜調整
                onTap: () {
                  debugPrint("広告がタップされました");
                },
              ),
            ),

            // おすすめリストタイトル
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
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
                  : VendorList(
                      vendors: allVendors,
                      favoritesProvider: favoritesProvider,
                      navigateToMyListScreen: false,
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(currentIndex: 1),
    );
  }
}