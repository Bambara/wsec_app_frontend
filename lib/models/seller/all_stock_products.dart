import 'package:json_annotation/json_annotation.dart';

import '../stock_product.dart';

part 'all_stock_products.g.dart';

@JsonSerializable(explicitToJson: true)
class AllStockProducts {
  List<StockProduct> stock;

  AllStockProducts(this.stock);

  factory AllStockProducts.fromJson(Map<String, dynamic> json) => _$AllStockProductsFromJson(json);

  Map<String, dynamic> toJson() => _$AllStockProductsToJson(this);
}
