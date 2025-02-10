import 'package:flutter/material.dart';
import 'package:fishing_app/widgets/list_item.dart';
import 'package:fishing_app/providers/favorites_provider.dart';

// 業者データのモデル
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
  final List<Vendor> vendors; // 業者リストデータ
  final FavoritesProvider favoritesProvider; // FavoritesProviderを受け取る

  const VendorList({
    required this.vendors,
    required this.favoritesProvider, // 必須パラメータに追加
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero, // リスト全体のパディングを削除
      physics: const AlwaysScrollableScrollPhysics(), // 業者リストをスクロール可能に設定
      itemCount: vendors.length > 10 ? 10 : vendors.length, // 最大10件まで表示
      itemBuilder: (context, index) {
        final vendor = vendors[index];
        // お気に入り登録済みかを判定
        final isFavorite = favoritesProvider.isFavorite(vendor.id);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.1, vertical: 1.5), // 他の画面と統一
          child: ListItem(
            title: vendor.title,
            location: vendor.location,
            imagePath: vendor.imagePath,
            isFavorite: isFavorite, // お気に入り状態を渡す
            onFavoritePressed: () {
              if (isFavorite) {
                // お気に入りから削除
                favoritesProvider.removeFavorite(vendor.id);
              } else {
                // お気に入りに追加
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
