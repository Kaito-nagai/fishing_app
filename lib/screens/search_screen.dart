import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';
import 'package:fishing_app/utils/json_loader.dart';
import 'package:fishing_app/components/vendor_list.dart';
import 'package:fishing_app/screens/search_results.dart';
import 'package:fishing_app/widgets/search_bar.dart';
import 'package:fishing_app/providers/favorites_provider.dart';
import 'package:fishing_app/widgets/ad_banner.dart';

// 🔹 ひらがな・カタカナ変換関数
String toHiragana(String input) {
  const katakanaStart = 0x30A1; // 'ァ'
  const katakanaEnd = 0x30F6;   // 'ヶ'
  return input.split('').map((char) {
    int code = char.codeUnitAt(0);
    if (code >= katakanaStart && code <= katakanaEnd) {
      return String.fromCharCode(code - 0x60); // カタカナをひらがなに変換
    }
    return char;
  }).join();
}

// 🔹 レーベンシュタイン距離計算
int levenshteinDistance(String s1, String s2) {
  if (s1 == s2) return 0;
  if (s1.isEmpty) return s2.length;
  if (s2.isEmpty) return s1.length;

  List<List<int>> matrix = List.generate(s1.length + 1, 
    (i) => List.filled(s2.length + 1, 0));

  for (int i = 0; i <= s1.length; i++) {
  matrix[i][0] = i;
}
for (int j = 0; j <= s2.length; j++) {
  matrix[0][j] = j;
}


  for (int i = 1; i <= s1.length; i++) {
    for (int j = 1; j <= s2.length; j++) {
      int cost = (s1[i - 1] == s2[j - 1]) ? 0 : 1;
      matrix[i][j] = [
        matrix[i - 1][j] + 1, 
        matrix[i][j - 1] + 1, 
        matrix[i - 1][j - 1] + cost
      ].reduce((a, b) => a < b ? a : b);
    }
  }
  return matrix[s1.length][s2.length];
}

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
    final normalizedQuery = toHiragana(query);  // 入力をひらがなに変換
    const int maxDistance = 3;  // 🔹 あいまい度を設定

    List<Vendor> results = allVendors.where((vendor) {
      final title = toHiragana(vendor.title);       
      final location = toHiragana(vendor.location);

      return levenshteinDistance(normalizedQuery, title) <= maxDistance ||
             levenshteinDistance(normalizedQuery, location) <= maxDistance;
    }).toList();

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
            Center(
              child: AdBanner(
                positionTop: 0.02,
                onTap: () {
                  debugPrint("広告がタップされました");
                },
              ),
            ),
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
