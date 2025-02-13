import 'package:flutter/material.dart';
import 'package:fishing_app/widgets/bottom_nav.dart';

class MyListReorderScreen extends StatefulWidget {
  const MyListReorderScreen({super.key});

  @override
  State<MyListReorderScreen> createState() => _MyListReorderScreenState();
}

class _MyListReorderScreenState extends State<MyListReorderScreen> {
  List<String> items = [
    '浜丸渡船',
    '林渡船',
    '弁天丸',
    '小川渡船',
    '谷口渡船',
    '松村渡船',
    'うりた渡船',
    '永田渡船',
  ];

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 0, // タイトルの位置を左寄せ
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8), // アイコンとテキストの間隔を調整
            const Text(
              'マイリスト',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            child: Text(
              '並べ替え',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Expanded(
            child: ReorderableListView(
              onReorder: _onReorder,
              padding: const EdgeInsets.only(top: 8),
              children: [
                for (final item in items)
                  ListTile(
                    key: ValueKey(item),
                    tileColor: Colors.grey[900],
                    title: Text(
                      item,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: const Icon(Icons.drag_handle, color: Colors.white),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
