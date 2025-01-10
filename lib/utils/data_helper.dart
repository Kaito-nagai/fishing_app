import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// JSONデータをロード
/// [path]: JSONファイルのパス
Future<List<dynamic>> loadJsonData(String path) async {
  try {
    if (kDebugMode) {
      debugPrint('DataHelper: Loading JSON data...');
    }
    final String response = await rootBundle.loadString(path);
    final data = json.decode(response) as List<dynamic>;
    if (kDebugMode) {
      debugPrint('DataHelper: JSON data loaded.');
    }
    return data;
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Error loading JSON data: $e');
    }
    return [];
  }
}

/// ランダムなデータを取得する
/// [data]: 元のデータリスト
/// [count]: 取得するランダムデータの数（デフォルトは5）
List<dynamic> getRandomData(List<dynamic> data, {int count = 5}) {
  final random = Random();
  final randomData = <dynamic>[];

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
List<dynamic> filterData({
  required List<dynamic> data,
  required String nameFilter,
  required String locationFilter,
  required List<bool> selectedPrices,
}) {
  return data.where((item) {
    final String name = item.name; // nullableではなくnon-nullable
    final String location = item.link ?? ''; // nullable を非null に対応
    final int price = 1000; // デフォルト値、修正可能

    final bool matchesName = 
        nameFilter.isEmpty || name.contains(nameFilter);
    final bool matchesLocation = 
        locationFilter.isEmpty || location.contains(locationFilter);
    final bool matchesPrice = selectedPrices.asMap().entries.any((entry) {
      if (entry.value) {
        final int minPrice = entry.key * 1000;
        final int maxPrice = (entry.key + 1) * 1000;
        return price >= minPrice && price < maxPrice;
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
