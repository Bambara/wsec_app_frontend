import 'package:json_annotation/json_annotation.dart';
import 'package:wsec_app_frontend/models/product.dart';

part 'loaded_product.g.dart';

@JsonSerializable(explicitToJson: true)
class LoadedProduct {
  final Product product;
  final double quantity;
  final double buy_price;
  final double sale_price;

  LoadedProduct(this.product, this.quantity, this.buy_price, this.sale_price);

  factory LoadedProduct.fromJson(Map<String, dynamic> json) => _$LoadedProductFromJson(json);

  Map<String, dynamic> toJson() => _$LoadedProductToJson(this);
}
