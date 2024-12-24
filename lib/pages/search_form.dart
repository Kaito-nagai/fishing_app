import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController locationController;
  final VoidCallback onConditionChanged;

  const SearchForm({
    super.key,
    required this.nameController,
    required this.locationController,
    required this.onConditionChanged,
  });


  @override
  Widget build(BuildContext context) {
    // デバッグログを追加
    debugPrint('✅ SearchForm がビルドされました');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('業者名', style: TextStyle(fontSize: 18)),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: '業者名を入力',
          ),
          onChanged: (value) {
            debugPrint('🔄 業者名が変更されました: $value');
            onConditionChanged();
          },
        ),
        const SizedBox(height: 16),
        const Text('場所', style: TextStyle(fontSize: 18)),
        TextField(
          controller: locationController,
          decoration: const InputDecoration(
            hintText: '場所を入力',
          ),
          onChanged: (value) {
            debugPrint('🔄 場所が変更されました: $value');
            onConditionChanged();
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
