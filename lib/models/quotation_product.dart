import 'package:json_annotation/json_annotation.dart';
import 'package:wsec_app_frontend/models/product.dart';

part 'quotation_product.g.dart';

@JsonSerializable(explicitToJson: true)
class QuotationProduct {
  final String id;
  final String quote_number;
  final Product product;
  final double buy_price;
  final double sell_price;
  final double qty;
  final double line_dis_value;
  final double line_dis_prece;
  final String store_id;

  QuotationProduct(this.id, this.quote_number, this.product, this.buy_price, this.sell_price, this.qty, this.line_dis_value, this.line_dis_prece, this.store_id);

  factory QuotationProduct.fromJson(Map<String, dynamic> json) => _$QuotationProductFromJson(json);

  Map<String, dynamic> toJson() => _$QuotationProductToJson(this);
}
