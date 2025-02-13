import 'package:flutter/material.dart';
import 'package:fishing_app/widgets/list_item.dart';
import 'package:fishing_app/providers/favorites_provider.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class Vendor {
  final String id;
  final String title;
  final String location;
  final String imagePath;

  Vendor({
    required this.id,
    required this.title,
    required this.location,
    required this.imagePath,
  });
}

class VendorList extends StatelessWidget {
  final List<Vendor> vendors;
  final FavoritesProvider favoritesProvider;
  final bool navigateToMyListScreen; // 遷移の制御

  const VendorList({
    required this.vendors,
    required this.favoritesProvider,
    this.navigateToMyListScreen = true, // デフォルトはtrue
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // 🔹 デバッグ用ログを追加
    logger.i("VendorList - navigateToMyListScreen: $navigateToMyListScreen");

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: vendors.length > 10 ? 10 : vendors.length,
      itemBuilder: (context, index) {
        final vendor = vendors[index];
        final isFavorite = favoritesProvider.isFavorite(vendor.id);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.1, vertical: 1.5),
          child: ListItem(
            title: vendor.title,
            location: vendor.location,
            imagePath: vendor.imagePath,
            isFavorite: isFavorite,
            navigateToMyListScreen: navigateToMyListScreen, // 追加
            onFavoritePressed: () {
              if (isFavorite) {
                favoritesProvider.removeFavorite(vendor.id);
              } else {
                favoritesProvider.addFavorite({
                  'id': vendor.id,
                  'name': vendor.title,
                  'location': vendor.location,
                  'imagePath': vendor.imagePath,
                });
              }
            },
          ),
        );
      },
    );
  }
}
