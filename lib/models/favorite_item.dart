class FavoriteItem {
  final String id;       // 一意識別子
  final String name;     // 業者名
  final String link;     // 外部リンク
  bool isFavorite;       // お気に入り状態

  FavoriteItem({
    required this.id,
    required this.name,
    required this.link,
    this.isFavorite = false,
  });

  // JSON形式に変換するメソッド
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'link': link,
      'isFavorite': isFavorite,
    };
  }

  // JSONからFavoriteItemインスタンスを生成するメソッド
  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'] as String,
      name: json['name'] as String,
      link: json['link'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}
