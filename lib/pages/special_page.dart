import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SpecialPage extends StatefulWidget {
  final String name;
  final String price;
  final String location;
  final String phoneNumber;

  const SpecialPage({
    super.key,
    required this.name,
    required this.price,
    required this.location,
    required this.phoneNumber,
  });

  @override
  SpecialPageState createState() => SpecialPageState();
}

class SpecialPageState extends State<SpecialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 業者名
            Text(
              '業者情報',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '料金: ${widget.price}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '場所: ${widget.location}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            // Googleマップ連携
            ElevatedButton.icon(
              onPressed: () async {
                final Uri mapUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${widget.location}');
                if (await canLaunchUrl(mapUri)) {
                  await launchUrl(mapUri);
                } else {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Googleマップを開けませんでした')),
                  );
                }
              },
              icon: const Icon(Icons.map),
              label: const Text('Googleマップで見る'),
            ),

            const SizedBox(height: 16),

            // 電話番号
            Text(
              '連絡先',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final Uri phoneUri = Uri(scheme: 'tel', path: widget.phoneNumber);
                if (await canLaunchUrl(phoneUri)) {
                  await launchUrl(phoneUri);
                } else {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('電話を開けませんでした')),
                  );
                }
              },
              child: Text(
                widget.phoneNumber,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 口コミセクション（仮）
            Text(
              '口コミ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // 仮の口コミ数
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.comment),
                    title: Text('ユーザー${index + 1}の口コミ'),
                    subtitle: const Text('とても良いサービスでした！'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

