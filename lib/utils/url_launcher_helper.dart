import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

Future<void> handleUrlLaunch(BuildContext context, String? url) async {
  void showSnackBar(String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  if (url == null || url.isEmpty) {
    showSnackBar('リンクが無効です');
    return;
  }

  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showSnackBar('リンクを開けませんでした: $url');
  }
}
