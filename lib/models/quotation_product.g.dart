// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotation_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuotationProduct _$QuotationProductFromJson(Map<String, dynamic> json) => QuotationProduct(
      json['id'] as String,
      json['quote_number'] as String,
      Product.fromJson(json['product'] as Map<String, dynamic>),
      (json['buy_price'] as num).toDouble(),
      (json['sell_price'] as num).toDouble(),
      (json['qty'] as num).toDouble(),
      (json['line_dis_value'] as num).toDouble(),
      (json['line_dis_prece'] as num).toDouble(),
      json['store_id'] as String,
    );

Map<String, dynamic> _$QuotationProductToJson(QuotationProduct instance) => <String, dynamic>{
      'id': instance.id,
      'quote_number': instance.quote_number,
      'product': instance.product.toJson(),
      'buy_price': instance.buy_price,
      'sell_price': instance.sell_price,
      'qty': instance.qty,
      'line_dis_value': instance.line_dis_value,
      'line_dis_prece': instance.line_dis_prece,
      'store_id': instance.store_id,
    };
