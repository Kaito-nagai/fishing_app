import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:flutter/services.dart';
import '../models/fishing_spot.dart';

/// JSONデータをロード
/// [path]: JSONファイルのパス
Future<List<FishingSpot>> loadJsonData(String path) async {
  try {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> jsonData = json.decode(response) as List<dynamic>;
    final List<FishingSpot> spots = jsonData
        .map((item) => FishingSpot.fromJson(item as Map<String, dynamic>))
        .toList();
    return spots;
  } catch (e) {
    return [];
  }
}

/// ランダムなデータを取得する
/// [data]: 元のデータリスト
/// [count]: 取得するランダムデータの数（デフォルトは5）
List<FishingSpot> getRandomData(List<FishingSpot> data, {int count = 5}) {
  final random = Random();
  final randomData = <FishingSpot>[];

  for (int i = 0; i < count && data.isNotEmpty; i++) {
    randomData.add(data[random.nextInt(data.length)]);
  }
  return randomData;
}

/// データをフィルタリングする
/// [data]: 元のデータリスト
/// [nameFilter]: 名前でのフィルタリング条件
/// [locationFilter]: 場所でのフィルタリング条件
/// [selectedPrices]: 選択された価格範囲
List<FishingSpot> filterData({
  required List<FishingSpot> data,
  required String nameFilter,
  required String locationFilter,
  required List<bool> selectedPrices,
}) {
  return data.where((item) {
    final bool matchesName =
        nameFilter.isEmpty || item.name.contains(nameFilter);
    final bool matchesLocation =
        locationFilter.isEmpty || item.location.contains(locationFilter);
    final bool matchesPrice = selectedPrices.asMap().entries.any((entry) {
      if (entry.value) {
        final int minPrice = entry.key * 1000;
        final int maxPrice = (entry.key + 1) * 1000;
        return item.price >= minPrice && item.price < maxPrice;
      }
      return false;
    });

    return matchesName && matchesLocation && matchesPrice;
  }).toList();
}

/// 入力条件変更時のディレイ処理
/// [filterCallback]: データフィルタリングコールバック関数
Timer onConditionChanged(VoidCallback filterCallback) {
  return Timer(const Duration(milliseconds: 500), filterCallback);
}
