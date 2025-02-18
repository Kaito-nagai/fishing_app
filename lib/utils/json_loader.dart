import 'dart:convert';
import 'package:flutter/services.dart'; // rootBundle を使用するため
import 'package:fishing_app/components/vendor_list.dart'; // Vendor クラスを使用する

// JSON データを読み取り、指定された都道府県のVendorリストに変換
Future<List<Vendor>> loadVendorsFromJson({String region = 'wakayama'}) async {
  // JSON データを読み込み
  final String response = await rootBundle.loadString('assets/data/vendors_data.json');
  final Map<String, dynamic> jsonData = json.decode(response);

  if (!jsonData.containsKey(region)) {
    throw Exception('指定された地域のデータが見つかりません');
  }

  final List<dynamic> data = jsonData[region];

  // Dart の Vendor クラスのリストに変換
  return data.map((item) => Vendor(
    id: item['id'], 
    title: item['name'], 
    location: item['location'], 
    imagePath: 'assets/images/placeholder_image.png', 
    catchInfo: item['catch_info'], 
  )).toList();
}
