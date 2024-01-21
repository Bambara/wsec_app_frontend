// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockProduct _$StockProductFromJson(Map<String, dynamic> json) => StockProduct(
      json['_id'] as String,
      json['name'] as String,
      json['product_code'] as String,
      json['bar_code'] as String,
      json['category'] as String,
      json['package_type'] as String,
      json['brand'] as String,
      json['status'] as String,
      (json['images'] as List<dynamic>).map((e) => Avatar.fromJson(e as Map<String, dynamic>)).toList(),
      (json['sale_price'] as num).toDouble(),
      (json['quantity'] as num).toDouble(),
    );

Map<String, dynamic> _$StockProductToJson(StockProduct instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'product_code': instance.product_code,
      'bar_code': instance.bar_code,
      'category': instance.category,
      'package_type': instance.package_type,
      'brand': instance.brand,
      'status': instance.status,
      'images': instance.images.map((e) => e.toJson()).toList(),
      'sale_price': instance.sale_price,
      'quantity': instance.quantity,
    };
