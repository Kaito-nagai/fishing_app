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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: '名前で検索'),
          onChanged: (value) => onConditionChanged(),
        ),
        TextField(
          controller: locationController,
          decoration: const InputDecoration(labelText: '場所で検索'),
          onChanged: (value) => onConditionChanged(),
        ),
      ],
    );
  }
}
