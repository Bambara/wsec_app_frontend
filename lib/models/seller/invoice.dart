import 'package:json_annotation/json_annotation.dart';

import '../invoice_product.dart';

part 'invoice.g.dart';

@JsonSerializable(explicitToJson: true)
class Invoice {
  final String id;
  final String number;
  final String create_time;
  final String modify_time;
  final String cashier_id;
  final String customer_id;
  final double item_count;
  final double total_amount;
  final double ld_amount;
  final double ld_percentage;
  final double gross_amount;
  final double bd_amount;
  final double bd_percentage;
  final double net_amount;
  final String pay_type;
  final String pay_number;
  final double payed_amount;
  final double due_amount;
  final String status;
  final String store_id;
  final List<InvoiceProduct> invoice_products;

  Invoice(
    this.id,
    this.number,
    this.create_time,
    this.modify_time,
    this.cashier_id,
    this.customer_id,
    this.item_count,
    this.total_amount,
    this.ld_amount,
    this.ld_percentage,
    this.gross_amount,
    this.bd_amount,
    this.bd_percentage,
    this.net_amount,
    this.pay_type,
    this.pay_number,
    this.payed_amount,
    this.due_amount,
    this.status,
    this.store_id,
    this.invoice_products,
  );

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}
