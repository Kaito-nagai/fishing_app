import 'package:flutter/material.dart';
import 'package:fishing_app/models/favorite_manager.dart';
import 'package:fishing_app/models/favorite_item.dart';
import 'package:fishing_app/pages/search_page.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FavoriteItem> _favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await FavoriteManager.loadFavorites();
    setState(() {
      _favoriteItems = favorites;
    });
  }

  Future<void> _removeFavorite(String id) async {
    await FavoriteManager.removeFavorite(id);
    _loadFavorites();
  }

  void _moveItem(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = _favoriteItems.removeAt(oldIndex);
      _favoriteItems.insert(newIndex, item);
    });
    FavoriteManager.saveFavorites(_favoriteItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入りリスト'),
      ),
      body: _favoriteItems.isEmpty
          ? const Center(
              child: Text(
                'お気に入りがまだありません',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ReorderableListView(
              onReorder: _moveItem,
              children: _favoriteItems.map((item) {
                return ListTile(
                  key: ValueKey(item.id),
                  title: Text(item.name),
                  subtitle: Text(item.link),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => _removeFavorite(item.id),
                  ),
                  onTap: () {
                    final Uri url = Uri.parse(item.link);
                    _handleUrlLaunch(url, item.link);
                  },
                );
              }).toList(),
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
        content: canLaunch
            ? Text('リンクを開けませんでした: $link')
            : Text('エラーが発生しました: $link'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
