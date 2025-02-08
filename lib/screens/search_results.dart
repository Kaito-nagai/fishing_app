import 'package:flutter/material.dart';
import '../components/vendor_list.dart';
import '../widgets/bottom_nav.dart'; // ボトムナビゲーションを追加

class SearchResults extends StatelessWidget {
  final List<Vendor> searchResults;

  const SearchResults({super.key, required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 背景を黒に設定
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          '検索結果',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: searchResults.isEmpty
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
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final vendor = searchResults[index];
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
      bottomNavigationBar: const BottomNav(currentIndex: 1), // 追加
    );
  }
}
