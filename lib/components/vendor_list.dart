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
      shrinkWrap: true, // Column内で使用するため shrinkWrap を有効化
      physics: const NeverScrollableScrollPhysics(), // 外側のスクロールと競合しないよう無効化
      itemCount: vendors.length,
      itemBuilder: (context, index) {
        final vendor = vendors[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
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
