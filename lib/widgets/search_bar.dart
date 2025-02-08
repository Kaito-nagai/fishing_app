import 'package:flutter/material.dart';

class SearchBarWithBackButton extends StatelessWidget {
  final VoidCallback onBackPressed;
  final ValueChanged<String> onSubmitted;
  final TextEditingController searchController;

  const SearchBarWithBackButton({
    super.key,
    required this.onBackPressed,
    required this.onSubmitted,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 16, top: 8, bottom: 8),
      child: Row(
        children: [
          // 戻るアイコン
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            iconSize: 24,
            onPressed: onBackPressed,
          ),
          // 検索バー
          Expanded(
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF424242),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                controller: searchController,
                onSubmitted: onSubmitted,
                style: TextStyle(
                  color: searchController.text.isEmpty
                      ? Colors.white70
                      : Colors.white, // 入力内容に応じた色
                ),
                decoration: const InputDecoration(
                  hintText: '業者名、場所などで検索',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 上下中央揃え
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
