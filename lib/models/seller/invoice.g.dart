// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      json['id'] as String,
      json['number'] as String,
      json['create_time'] as String,
      json['modify_time'] as String,
      json['cashier_id'] as String,
      json['customer_id'] as String,
      (json['item_count'] as num).toDouble(),
      (json['total_amount'] as num).toDouble(),
      (json['ld_amount'] as num).toDouble(),
      (json['ld_percentage'] as num).toDouble(),
      (json['gross_amount'] as num).toDouble(),
      (json['bd_amount'] as num).toDouble(),
      (json['bd_percentage'] as num).toDouble(),
      (json['net_amount'] as num).toDouble(),
      json['pay_type'] as String,
      json['pay_number'] as String,
      (json['payed_amount'] as num).toDouble(),
      (json['due_amount'] as num).toDouble(),
      json['status'] as String,
      json['store_id'] as String,
      (json['invoice_products'] as List<dynamic>).map((e) => InvoiceProduct.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'create_time': instance.create_time,
      'modify_time': instance.modify_time,
      'cashier_id': instance.cashier_id,
      'customer_id': instance.customer_id,
      'item_count': instance.item_count,
      'total_amount': instance.total_amount,
      'ld_amount': instance.ld_amount,
      'ld_percentage': instance.ld_percentage,
      'gross_amount': instance.gross_amount,
      'bd_amount': instance.bd_amount,
      'bd_percentage': instance.bd_percentage,
      'net_amount': instance.net_amount,
      'pay_type': instance.pay_type,
      'pay_number': instance.pay_number,
      'payed_amount': instance.payed_amount,
      'due_amount': instance.due_amount,
      'status': instance.status,
      'store_id': instance.store_id,
      'invoice_products': instance.invoice_products.map((e) => e.toJson()).toList(),
    };
