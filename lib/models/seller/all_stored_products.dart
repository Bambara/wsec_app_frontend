import 'package:json_annotation/json_annotation.dart';

import '../product.dart';

part 'all_stored_products.g.dart';

@JsonSerializable(explicitToJson: true)
class AllStoredProducts {
  List<Product> products;

  AllStoredProducts(this.products);

  factory AllStoredProducts.fromJson(Map<String, dynamic> json) => _$AllStoredProductsFromJson(json);

  Map<String, dynamic> toJson() => _$AllStoredProductsToJson(this);
}
