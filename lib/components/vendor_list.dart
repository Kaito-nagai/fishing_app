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
  final String catchInfo; // 🔹 新規追加：catch_infoを保持

  Vendor({
    required this.id,
    required this.title,
    required this.location,
    required this.imagePath,
    required this.catchInfo, // 🔹 コンストラクタに追加
  });
}

class VendorList extends StatelessWidget {
  final List<Vendor> vendors;
  final FavoritesProvider favoritesProvider;
  final bool navigateToMyListScreen;

  const VendorList({
    required this.vendors,
    required this.favoritesProvider,
    this.navigateToMyListScreen = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            navigateToMyListScreen: navigateToMyListScreen,
            catchInfoUrl: vendor.catchInfo, // 🔹 ListItemにcatch_infoを渡す
            onFavoritePressed: () {
              if (isFavorite) {
                favoritesProvider.removeFavorite(vendor.id);
              } else {
                favoritesProvider.addFavorite({
                  'id': vendor.id,
                  'name': vendor.title,
                  'location': vendor.location,
                  'imagePath': vendor.imagePath,
                  'catchInfo': vendor.catchInfo, // 🔹 お気に入りにもcatch_infoを追加
                });
              }
            },
          ),
        );
      },
    );
  }
}
