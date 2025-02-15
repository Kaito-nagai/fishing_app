import 'package:flutter/material.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';
import 'package:fishing_app/providers/favorites_provider.dart';
import 'package:fishing_app/widgets/reorderable_list_item.dart';
import 'package:provider/provider.dart';

class MyListReorderScreen extends StatefulWidget {
  const MyListReorderScreen({super.key});

  @override
  State<MyListReorderScreen> createState() => _MyListReorderScreenState();
}

class _MyListReorderScreenState extends State<MyListReorderScreen> {
  void _moveItemUp(int index, FavoritesProvider favoritesProvider) {
    if (index > 0) {
      setState(() {
        final item = favoritesProvider.favorites.removeAt(index);
        favoritesProvider.favorites.insert(index - 1, item);
        favoritesProvider.updateFavorites();
      });
    }
  }

  void _moveItemDown(int index, FavoritesProvider favoritesProvider) {
    if (index < favoritesProvider.favorites.length - 1) {
      setState(() {
        final item = favoritesProvider.favorites.removeAt(index);
        favoritesProvider.favorites.insert(index + 1, item);
        favoritesProvider.updateFavorites();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteVendors = favoritesProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleSpacing: 8,
        title: const Text(
          'マイリスト',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            child: Text(
              '並べ替え',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: favoriteVendors.length,
              itemBuilder: (context, index) {
                final vendor = favoriteVendors[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0), // アイテム間の余白を追加
                  child: ReorderableListItem(
                    key: ValueKey(vendor['id']),
                    title: vendor['name'],
                    location: vendor['location'],
                    imagePath: vendor['imagePath'],
                    isFavorite: favoritesProvider.isFavorite(vendor['id']),
                    onFavoritePressed: () {
                      favoritesProvider.removeFavorite(vendor['id']);
                    },
                    onMoveUp: () => _moveItemUp(index, favoritesProvider),
                    onMoveDown: () => _moveItemDown(index, favoritesProvider),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
