import 'package:json_annotation/json_annotation.dart';
import 'package:wsec_app_frontend/models/user/avatar.dart';

part 'stock_product.g.dart';

@JsonSerializable(explicitToJson: true)
class StockProduct {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String product_code;

  // @JsonKey(name: 'barcode')
  final String bar_code;

  final String category;
  final String package_type;
  final String brand;
  final String status;
  final List<Avatar> images;

  // final String batch_code;
  // final double buy_price;
  final double sale_price;
  final double quantity;

  StockProduct(this.id, this.name, this.product_code, this.bar_code, this.category, this.package_type, this.brand, this.status, this.images, this.sale_price, this.quantity);

  factory StockProduct.fromJson(Map<String, dynamic> json) => _$StockProductFromJson(json);

  Map<String, dynamic> toJson() => _$StockProductToJson(this);
}
