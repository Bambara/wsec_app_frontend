// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quotation _$QuotationFromJson(Map<String, dynamic> json) => Quotation(
      json['id'] as String,
      json['number'] as String,
      json['create_date'] as String,
      json['create_time'] as String,
      json['modify_date'] as String,
      json['modify_time'] as String,
      (json['item_count'] as num).toDouble(),
      json['requester_id'] as String,
      json['responses_id'] as String,
      (json['total_amount'] as num).toDouble(),
      (json['ld_amount'] as num).toDouble(),
      (json['ld_percentage'] as num).toDouble(),
      (json['ld_qty'] as num).toDouble(),
      (json['gross_amount'] as num).toDouble(),
      (json['bd_amount'] as num).toDouble(),
      (json['bd_percentage'] as num).toDouble(),
      (json['net_amount'] as num).toDouble(),
      json['status'] as String,
      json['store_id'] as String,
      (json['quotation_products'] as List<dynamic>).map((e) => QuotationProduct.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$QuotationToJson(Quotation instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'create_date': instance.create_date,
      'create_time': instance.create_time,
      'modify_date': instance.modify_date,
      'modify_time': instance.modify_time,
      'item_count': instance.item_count,
      'requester_id': instance.requester_id,
      'responses_id': instance.responses_id,
      'total_amount': instance.total_amount,
      'ld_amount': instance.ld_amount,
      'ld_percentage': instance.ld_percentage,
      'ld_qty': instance.ld_qty,
      'gross_amount': instance.gross_amount,
      'bd_amount': instance.bd_amount,
      'bd_percentage': instance.bd_percentage,
      'net_amount': instance.net_amount,
      'status': instance.status,
      'store_id': instance.store_id,
      'quotation_products': instance.quotation_products.map((e) => e.toJson()).toList(),
    };
