import 'package:json_annotation/json_annotation.dart';

import 'stock_product.dart';

part 'invoice_product.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoiceProduct {
  final String id;
  final String invoice_number;
  final StockProduct stock_product;
  final double buy_price;
  final double sell_price;
  final double qty;
  final double ld_amount;
  final double ld_percentage;
  final double ld_qty;
  final String status;
  final String store_id;

  InvoiceProduct(this.id, this.invoice_number, this.stock_product, this.buy_price, this.sell_price, this.qty, this.ld_amount, this.ld_percentage, this.ld_qty, this.status,
      this.store_id);

  factory InvoiceProduct.fromJson(Map<String, dynamic> json) => _$InvoiceProductFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceProductToJson(this);
}
