import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart'; // Loggerをインポート

class PlacesApiHelper {
  static final Logger _logger = Logger(); // Loggerインスタンスを作成
  static final String _apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  static final String _baseUrl =
      'https://maps.googleapis.com/maps/api/place/textsearch/json';

  /// 和歌山県で「渡船屋」を検索する関数
  static Future<List<Map<String, dynamic>>> searchFerryOperators() async {
    final String proxyUrl = 'https://cors-anywhere.herokuapp.com/';
    final String query = Uri.encodeQueryComponent('渡船屋 in 和歌山県');
    final String url = '$proxyUrl$_baseUrl?query=$query&key=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _logger.i('APIリクエスト成功: ${data['results']}'); // 成功ログ
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        _logger.e('データ取得に失敗しました: ${response.statusCode}, body: ${response.body}'); // 詳細なエラーログ
        return [];
      }
    } catch (e) {
      _logger.e('エラーが発生しました: $e'); // 例外ログ
      return [];
    }
  }
}


