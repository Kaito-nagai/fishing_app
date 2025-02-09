import 'package:flutter/material.dart';
import 'package:fishing_app/widgets/list_item.dart';
import 'package:fishing_app/models/favorite_manager.dart';
import 'package:fishing_app/models/favorite_item.dart';

// 業者データのモデル
class Vendor {
  final String id; // 修正: IDを追加
  final String title;
  final String location;
  final String imagePath;

  Vendor({
    required this.id, // 修正: IDを必須に
    required this.title,
    required this.location,
    required this.imagePath,
  });
}

class VendorList extends StatelessWidget {
  final List<Vendor> vendors; // 業者リストデータ
  final FavoriteManager favoriteManager; // 修正: FavoriteManagerを追加

  const VendorList({
    required this.vendors,
    required this.favoriteManager, // 修正: FavoriteManagerを必須に
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero, // リスト全体のパディングを削除
      physics: const AlwaysScrollableScrollPhysics(), // 業者リストをスクロール可能に設定
      itemCount: vendors.length > 10 ? 10 : vendors.length, // 最大表示数10件
      itemBuilder: (context, index) {
        final vendor = vendors[index];
        final isFavorite = favoriteManager.favorites.any((fav) => fav.id == vendor.id);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.1, vertical: 1.5), // 他の画面と統一
          child: ListItem(
            title: vendor.title,
            location: vendor.location,
            imagePath: vendor.imagePath,
            isFavorite: isFavorite, // 修正: お気に入り状態を渡す
            onFavoritePressed: () {
              favoriteManager.toggleFavorite(
                FavoriteItem(
                  id: vendor.id,
                  name: vendor.title,
                  link: '', // 必要に応じてリンクを渡す
                ),
              );
            },
          ),
        );
      },
    );
  }
}
