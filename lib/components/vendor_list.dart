import 'package:flutter/material.dart';
import 'package:fishing_app/widgets/list_item.dart';

// 業者データのモデル
class Vendor {
  final String title;
  final String location;
  final String imagePath;

  Vendor({
    required this.title,
    required this.location,
    required this.imagePath,
  });
}

class VendorList extends StatelessWidget {
  final List<Vendor> vendors; // 業者リストデータ

  const VendorList({required this.vendors, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero, // リスト全体のパディングを削除
      physics: const AlwaysScrollableScrollPhysics(), // 業者リストをスクロール可能に設定
      itemCount: vendors.length,
      itemBuilder: (context, index) {
        final vendor = vendors[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0), // リストアイテム間の余白を調整
          child: ListItem(
            title: vendor.title,
            location: vendor.location,
            imagePath: vendor.imagePath,
          ),
        );
      },
    );
  }
}
