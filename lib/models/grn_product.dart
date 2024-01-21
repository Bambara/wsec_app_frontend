import 'package:json_annotation/json_annotation.dart';

part 'grn_product.g.dart';

@JsonSerializable(explicitToJson: true)
class GRNProduct {
  final String productId;
  final double quantity;
  final double buy_price;
  final double sale_price;

  GRNProduct(this.productId, this.quantity, this.buy_price, this.sale_price);

  factory GRNProduct.fromJson(Map<String, dynamic> json) => _$GRNProductFromJson(json);

  Map<String, dynamic> toJson() => _$GRNProductToJson(this);
}
