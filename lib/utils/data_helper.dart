import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// JSONデータをロード
Future<List<dynamic>> loadJsonData(String path) async {
  try {
    if (kDebugMode) {
      debugPrint('DataHelper: Loading JSON data...');
    }
    final String response = await rootBundle.loadString(path);
    final data = json.decode(response);
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

/// ランダムデータを取得
List<dynamic> getRandomData(List<dynamic> data) {
  final random = Random();
  final randomData = <dynamic>[];
  for (int i = 0; i < 5 && data.isNotEmpty; i++) {
    randomData.add(data[random.nextInt(data.length)]);
  }
  return randomData;
}

/// データをフィルタリング
List<dynamic> filterData({
  required List<dynamic> data,
  required String nameFilter,
  required String locationFilter,
  required List<bool> selectedPrices,
}) {
  return data.where((item) {
    final String name = item['name'];
    final String location = item['location'];
    final int price = item['price'];

    final bool matchesName = nameFilter.isEmpty || name.contains(nameFilter);
    final bool matchesLocation = locationFilter.isEmpty || location.contains(locationFilter);
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
Timer onConditionChanged(VoidCallback filterCallback) {
  return Timer(const Duration(milliseconds: 500), filterCallback);
}
