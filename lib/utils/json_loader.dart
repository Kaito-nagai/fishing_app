import 'dart:convert';
import 'package:flutter/services.dart'; // rootBundle を使用するため
import 'package:fishing_app/components/vendor_list.dart'; // Vendor クラスを使用する

// JSON データを読み取り、Vendor のリストに変換
Future<List<Vendor>> loadVendorsFromJson() async {
  // JSON データを読み込み
  final String response = await rootBundle.loadString('assets/data/wakayama_data.json');
  final List<dynamic> data = json.decode(response);

  // Dart の Vendor クラスのリストに変換
  return data.map((item) => Vendor(
    id: item['id'], // 修正: id を追加
    title: item['name'], // JSON の "name" を Dart の title に対応
    location: item['location'], // JSON の "location" を Dart の location に対応
    imagePath: 'assets/images/placeholder_image.png', // 仮の画像パス
    catchInfo: item['catch_info'], // 🔹 追加
  )).toList();
}
