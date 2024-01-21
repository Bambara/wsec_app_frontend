// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProduct _$AddProductFromJson(Map<String, dynamic> json) => AddProduct(
      json['_id'] as String,
      json['name'] as String,
      json['product_code'] as String,
      json['bar_code'] as String,
      json['category'] as String,
      json['package_type'] as String,
      json['brand'] as String,
      json['status'] as String,
      (json['images'] as List<dynamic>).map((e) => Avatar.fromJson(e as Map<String, dynamic>)).toList(),
      (json['productPrices'] as List<dynamic>).map((e) => ProductPrice.fromJson(e as Map<String, dynamic>)).toList(),
      json['store_id'] as String,
    );

Map<String, dynamic> _$AddProductToJson(AddProduct instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'product_code': instance.product_code,
      'bar_code': instance.bar_code,
      'category': instance.category,
      'package_type': instance.package_type,
      'brand': instance.brand,
      'status': instance.status,
      'images': instance.images.map((e) => e.toJson()).toList(),
      'productPrices': instance.productPrices.map((e) => e.toJson()).toList(),
      'store_id': instance.store_id,
    };
