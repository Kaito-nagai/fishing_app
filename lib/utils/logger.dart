import 'package:logger/logger.dart';

/// グローバルで使用可能な Logger インスタンス
final Logger logger = Logger(
  printer: PrettyPrinter(), // ログ出力を見やすく整形
);
