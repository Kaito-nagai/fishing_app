import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/favorite_button.dart';
import 'search_page.dart';
import 'special_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お気に入りリスト'),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favoriteItems = favoritesProvider.favorites;

          if (favoriteItems.isEmpty) {
            return const Center(
              child: Text(
                'お気に入りがまだありません',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: favoriteItems.length,
            itemBuilder: (context, index) {
              final item = favoriteItems[index];
              final bool hasWebsite = (item['link'] ?? '').isNotEmpty;

              return GestureDetector(
                onTap: () async {
                  if (hasWebsite) {
                    final Uri url = Uri.parse(item['link'] ?? '');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('リンクを開けませんでした: ${item['link']}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      });
                    }
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialPage(
                          name: item['name'] ?? '不明な業者',
                          price: item['price'] != null ? '${item['price']}円' : '料金不明',
                          location: item['location'] ?? '場所不明',
                          phoneNumber: '未設定', // 仮の電話番号
                        ),
                      ),
                    );
                  }
                },
                child: Card(
                  color: hasWebsite ? Colors.blue : Colors.grey.shade300,
                  child: ListTile(
                    title: Text(
                      item['name'] ?? '不明な業者',
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      hasWebsite ? item['link'] ?? '' : 'リンクなし',
                      style: TextStyle(
                        color: hasWebsite ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    trailing: FavoriteButton(
                      favoriteKey: item['id'] ?? '',
                      initialIsFavorite: favoritesProvider.isFavorite(item['id']),
                      onFavoriteUpdated: () {
                        if (favoritesProvider.isFavorite(item['id'])) {
                          favoritesProvider.removeFavorite(item['id']);
                        } else {
                          favoritesProvider.addFavorite(item);
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 検索ページに移動
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(
                favoriteItems: context.read<FavoritesProvider>().favorites,
              ),
            ),
          );

          // 戻ってきた後のUI更新
          if (mounted) {
            setState(() {}); // 必要に応じて再描画
          }
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}

