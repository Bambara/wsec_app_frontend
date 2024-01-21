import 'package:json_annotation/json_annotation.dart';
import 'package:wsec_app_frontend/models/seller/product_prices.dart';
import 'package:wsec_app_frontend/models/user/avatar.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String product_code;
  final String bar_code;
  final String category;
  final String package_type;
  final String brand;
  final String status;
  final List<Avatar> images;
  final List<ProductPrice> productPrices;

  Product(this.id, this.name, this.product_code, this.bar_code, this.category, this.package_type, this.brand, this.status, this.images,
      this.productPrices); // Product(this.id, this.name, this.product_code, this.bar_code, this.package_type, this.brand, this.store_id, this.category, this.images, this.status, this.productPrices);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
