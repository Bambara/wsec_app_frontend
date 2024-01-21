// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grn_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GRNProduct _$GRNProductFromJson(Map<String, dynamic> json) => GRNProduct(
      json['productId'] as String,
      (json['quantity'] as num).toDouble(),
      (json['buy_price'] as num).toDouble(),
      (json['sale_price'] as num).toDouble(),
    );

Map<String, dynamic> _$GRNProductToJson(GRNProduct instance) => <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'buy_price': instance.buy_price,
      'sale_price': instance.sale_price,
    };
