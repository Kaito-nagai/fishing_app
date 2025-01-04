import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

Future<void> handleUrlLaunch(BuildContext context, String? url) async {
  if (url == null || url.isEmpty) {
    if (!context.mounted) return; // mounted チェック
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('リンクが無効です'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    if (!context.mounted) return; // mounted チェック
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('リンクを開けませんでした: $url'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
