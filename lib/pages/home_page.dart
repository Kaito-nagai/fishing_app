import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/favorite_button.dart';
import '../pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> favoriteItems = []; // お気に入りリスト

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // お気に入りデータをロード
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList = prefs.getStringList('favorite_list') ?? [];
    setState(() {
      favoriteItems = favoriteList.map((key) {
        return {
          'id': key,
          'name': 'お気に入り業者 $key',
          'link': 'https://example.com/$key',
        };
      }).toList();
    });
  }

  Future<void> _handleUrlLaunch(Uri url, String link) async {
    bool canLaunch = false;
    try {
      canLaunch = await canLaunchUrl(url);
      if (canLaunch) {
        await launchUrl(url);
        return;
      }
    } catch (e) {
      canLaunch = false;
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          canLaunch ? 'リンクを開けませんでした: $link' : 'エラーが発生しました: $link',
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入りリスト'),
      ),
      body: favoriteItems.isEmpty
          ? const Center(
              child: Text(
                'お気に入りがまだありません',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return ListTile(
                  key: ValueKey(item['id']),
                  title: Text(item['name'] ?? '不明な業者'),
                  subtitle: Text(item['link'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FavoriteButton(
                        favoriteKey: item['id'] ?? '',
                        favoriteName: item['name'] ?? '',
                        favoriteCount: 10,
                        onFavoriteUpdated: _loadFavorites,
                      ),
                      IconButton(
                        icon: const Icon(Icons.link, color: Colors.blue),
                        onPressed: () {
                          final Uri url = Uri.parse(item['link'] ?? '');
                          _handleUrlLaunch(url, item['link'] ?? '');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchPage()),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
