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
          Container(width: double.infinity, height: 1, color: Colors.grey),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            child: Text('並べ替え', style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          Expanded(
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = favoriteVendors.removeAt(oldIndex);
                  favoriteVendors.insert(newIndex, item);
                  favoritesProvider.updateFavorites();
                });
              },
              children: [
                for (int index = 0; index < favoriteVendors.length; index++)
                  Padding(
                    key: ValueKey(favoriteVendors[index]['id']),
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: ReorderableListItem(
                      key: ValueKey(favoriteVendors[index]['id']),
                      title: favoriteVendors[index]['name'],
                      location: favoriteVendors[index]['location'],
                      imagePath: favoriteVendors[index]['imagePath'],
                      isFavorite: favoritesProvider.isFavorite(favoriteVendors[index]['id']),
                      onFavoritePressed: () {
                        favoritesProvider.removeFavorite(favoriteVendors[index]['id']);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
