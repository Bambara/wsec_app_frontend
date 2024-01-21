// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_prices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPrice _$ProductPriceFromJson(Map<String, dynamic> json) => ProductPrice(
      json['_id'] as String,
      (json['buy_price'] as num).toDouble(),
      (json['sale_price'] as num).toDouble(),
      (json['quantity'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductPriceToJson(ProductPrice instance) => <String, dynamic>{
      '_id': instance.id,
      'buy_price': instance.buy_price,
      'sale_price': instance.sale_price,
      'quantity': instance.quantity,
    };
