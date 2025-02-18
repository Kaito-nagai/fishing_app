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
  final String catchInfo;

  Vendor({
    required this.id,
    required this.title,
    required this.location,
    required this.imagePath,
    required this.catchInfo,
  });
}

class VendorList extends StatelessWidget {
  final List<Vendor> vendors;
  final FavoritesProvider favoritesProvider;
  final bool navigateToMyListScreen;

  const VendorList({
    required this.vendors,
    required this.favoritesProvider,
    this.navigateToMyListScreen = false, // 🔹 初期値をfalseに変更
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    logger.i("VendorList - navigateToMyListScreen: $navigateToMyListScreen");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.1, vertical: 2.5),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: vendors.length > 10 ? 10 : vendors.length,
        itemBuilder: (context, index) {
          final vendor = vendors[index];
          final isFavorite = favoritesProvider.isFavorite(vendor.id);

          return ListItem(
            title: vendor.title,
            location: vendor.location,
            imagePath: vendor.imagePath,
            isFavorite: isFavorite,
            navigateToMyListScreen: navigateToMyListScreen, // 🔹 必要な場面でtrueに
            catchInfoUrl: vendor.catchInfo,
            onFavoritePressed: () {
              if (isFavorite) {
                favoritesProvider.removeFavorite(vendor.id);
              } else {
                favoritesProvider.addFavorite({
                  'id': vendor.id,
                  'name': vendor.title,
                  'location': vendor.location,
                  'imagePath': vendor.imagePath,
                  'catchInfo': vendor.catchInfo,
                });
              }
            },
          );
        },
      ),
    );
  }
}
