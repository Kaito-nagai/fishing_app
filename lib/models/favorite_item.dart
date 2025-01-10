class FavoriteItem {
  final String id;
  final String name;
  final String? link; 

  FavoriteItem({
    required this.id,
    required this.name,
    this.link, 
  });

  /// JSONからオブジェクトを作成
  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
  return FavoriteItem(
    id: json['id'] ?? '', 
    name: json['name'] ?? '',
    link: json['link'] ?? '',
  );
}

  /// オブジェクトをJSONに変換
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'link': link,
    };
  }
}
