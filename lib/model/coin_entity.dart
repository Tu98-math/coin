class CoinEntity {
  String? name;
  String? top;
  double? price;
  String? image;
  double? percent;

  CoinEntity({this.name, this.top, this.image, this.price, this.percent});

  factory CoinEntity.fromJson() {}
}
