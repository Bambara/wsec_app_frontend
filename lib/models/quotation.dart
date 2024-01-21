import 'package:json_annotation/json_annotation.dart';
import 'package:wsec_app_frontend/models/quotation_product.dart';

part 'quotation.g.dart';

@JsonSerializable(explicitToJson: true)
class Quotation {
  final String id;
  final String number;
  final String create_date;
  final String create_time;
  final String modify_date;
  final String modify_time;
  final double item_count;
  final String requester_id;
  final String responses_id;
  final double total_amount;
  final double ld_amount;
  final double ld_percentage;
  final double ld_qty;
  final double gross_amount;
  final double bd_amount;
  final double bd_percentage;
  final double net_amount;
  final String status;
  final String store_id;
  final List<QuotationProduct> quotation_products;

  Quotation(
      this.id,
      this.number,
      this.create_date,
      this.create_time,
      this.modify_date,
      this.modify_time,
      this.item_count,
      this.requester_id,
      this.responses_id,
      this.total_amount,
      this.ld_amount,
      this.ld_percentage,
      this.ld_qty,
      this.gross_amount,
      this.bd_amount,
      this.bd_percentage,
      this.net_amount,
      this.status,
      this.store_id,
      this.quotation_products);

  factory Quotation.fromJson(Map<String, dynamic> json) => _$QuotationFromJson(json);

  Map<String, dynamic> toJson() => _$QuotationToJson(this);
}
