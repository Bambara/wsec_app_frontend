// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceProduct _$InvoiceProductFromJson(Map<String, dynamic> json) => InvoiceProduct(
      json['id'] as String,
      json['invoice_number'] as String,
      StockProduct.fromJson(json['stock_product'] as Map<String, dynamic>),
      (json['buy_price'] as num).toDouble(),
      (json['sell_price'] as num).toDouble(),
      (json['qty'] as num).toDouble(),
      (json['ld_amount'] as num).toDouble(),
      (json['ld_percentage'] as num).toDouble(),
      (json['ld_qty'] as num).toDouble(),
      json['status'] as String,
      json['store_id'] as String,
    );

Map<String, dynamic> _$InvoiceProductToJson(InvoiceProduct instance) => <String, dynamic>{
      'id': instance.id,
      'invoice_number': instance.invoice_number,
      'stock_product': instance.stock_product.toJson(),
      'buy_price': instance.buy_price,
      'sell_price': instance.sell_price,
      'qty': instance.qty,
      'ld_amount': instance.ld_amount,
      'ld_percentage': instance.ld_percentage,
      'ld_qty': instance.ld_qty,
      'status': instance.status,
      'store_id': instance.store_id,
    };
