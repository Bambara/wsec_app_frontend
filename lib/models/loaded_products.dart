import 'package:json_annotation/json_annotation.dart';

import 'grn_product.dart';

part 'loaded_products.g.dart';

@JsonSerializable(explicitToJson: true)
class LoadedProducts {
  final String supplier;
  final String fullName;

  // final Address address;
  // final Contact contact;
  final String address;
  final String postalCode;
  final String city;
  final String country;
  final List<GRNProduct> items;

  LoadedProducts(this.supplier, this.fullName, this.address, this.postalCode, this.city, this.country, this.items);

  factory LoadedProducts.fromJson(Map<String, dynamic> json) => _$LoadedProductsFromJson(json);

  Map<String, dynamic> toJson() => _$LoadedProductsToJson(this);
}
