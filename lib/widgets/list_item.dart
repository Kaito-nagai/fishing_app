import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  final String title; // 業者名（例: 浜丸渡船・林渡船）
  final String location; // 所在地（例: 和歌山県すさみ町見老津）
  final String imagePath; // サムネイル画像
  final bool isFavorite; // お気に入り状態を追加
  final VoidCallback? onFavoritePressed;

  const ListItem({
    super.key,
    required this.title,
    required this.location,
    required this.imagePath,
    required this.isFavorite, // 必須パラメータに設定
    this.onFavoritePressed,
  });

  @override
  ListItemState createState() => ListItemState(); // 修正: アンダースコアを削除
}

class ListItemState extends State<ListItem> { // 修正: アンダースコアを削除
  late bool _isFavorite;


  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite; // 初期状態を設定
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite; // お気に入り状態を切り替え
    });
    if (widget.onFavoritePressed != null) {
      widget.onFavoritePressed!(); // 外部イベントを呼び出し
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.07,
      child: Stack(
        children: [
          // 背景のカードデザイン
          Container(
            width: double.infinity,
            height: screenHeight * 0.07,
            decoration: BoxDecoration(
              color: const Color(0xFF2E2E2E),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                const BoxShadow(
                  color: Color.fromARGB(64, 0, 0, 0),
                  offset: Offset(4, 4),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          // お気に入りアイコン
          Positioned(
            left: screenWidth * 0.87,
            top: screenHeight * 0.021,
            child: IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.grey,
                size: screenWidth * 0.053,
              ),
              onPressed: _toggleFavorite, // 状態を切り替える処理
            ),
          ),
          // 所在地
          Positioned(
            left: screenWidth * 0.332,
            top: screenHeight * 0.036,
            child: Opacity(
              opacity: 0.50,
              child: Text(
                widget.location,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.034,
                  fontFamily: 'Noto Sans JP',
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          // ロケーションアイコン
          Positioned(
            left: screenWidth * 0.295,
            top: screenHeight * 0.039,
            child: Icon(
              Icons.location_pin,
              size: screenWidth * 0.035,
              color: const Color(0xFF777777),
            ),
          ),
          // **業者名（浜丸渡船・林渡船）**
          Positioned(
            left: screenWidth * 0.30,
            top: screenHeight * 0.008,
            child: SizedBox(
              width: screenWidth * 0.3,
              height: screenHeight * 0.06,
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.045,
                  fontFamily: 'Noto Sans JP',
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          // サムネイル画像
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: screenWidth * 0.25,
              height: screenHeight * 0.07,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
