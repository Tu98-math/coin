class CoinEntity {
  String? id;
  String? name;
  int? top;
  String? price;
  String? image;
  double? percent;

  CoinEntity(
      {this.id, this.name, this.top, this.image, this.price, this.percent});

  factory CoinEntity.fromJson(Map<String, dynamic> json) {
    return CoinEntity(
        id: json['id'],
        name: json['name'],
        top: json['market_cap_rank'],
        image: json['image'],
        price: json['current_price'].toString(),
        percent: json['price_change_percentage_24h']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'market_cap_rank': top,
        'image': image,
        'current_price': price,
        'price_change_percentage_24h': percent
      };
}
