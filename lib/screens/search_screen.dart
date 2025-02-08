import 'package:flutter/material.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';
import 'package:fishing_app/utils/json_loader.dart';
import 'package:fishing_app/components/vendor_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List<Vendor> allVendors = [];

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
                    iconSize: 24, // サイズを指定
                    onPressed: () {
                      Navigator.pop(context); // ホーム画面に戻る
                    },
                  ),
                  // 検索バー
                  Expanded(
                    child: Container(
                      height: 32, // 高さを指定
                      decoration: BoxDecoration(
                        color: const Color(0xFF424242),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '業者名、場所などで検索',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left, // 左寄せ
                          ),
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
      bottomNavigationBar: const BottomNav(),
    );
  }
}
