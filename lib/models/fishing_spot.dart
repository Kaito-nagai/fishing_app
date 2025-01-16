class FishingSpot {
  final String id;
  final String name;
  final String location;
  final int price;
  final String link;

  FishingSpot({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.link,
  });

  factory FishingSpot.fromJson(Map<String, dynamic> json) {
    return FishingSpot(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      price: json['price'] as int,
      link: json['link'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'price': price,
      'link': link,
    };
  }
}