// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loaded_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadedProduct _$LoadedProductFromJson(Map<String, dynamic> json) => LoadedProduct(
      Product.fromJson(json['product'] as Map<String, dynamic>),
      (json['quantity'] as num).toDouble(),
      (json['buy_price'] as num).toDouble(),
      (json['sale_price'] as num).toDouble(),
    );

Map<String, dynamic> _$LoadedProductToJson(LoadedProduct instance) => <String, dynamic>{
      'product': instance.product.toJson(),
      'quantity': instance.quantity,
      'buy_price': instance.buy_price,
      'sale_price': instance.sale_price,
    };
