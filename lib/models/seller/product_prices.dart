import 'package:json_annotation/json_annotation.dart';

part 'product_prices.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductPrice {
  @JsonKey(name: '_id')
  String id;
  double buy_price;
  double sale_price;
  double quantity;

  ProductPrice(this.id, this.buy_price, this.sale_price, this.quantity); // ProductPrice(this.sale_price, this.quantity, this.id);

  factory ProductPrice.fromJson(Map<String, dynamic> json) => _$ProductPriceFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPriceToJson(this);
}
