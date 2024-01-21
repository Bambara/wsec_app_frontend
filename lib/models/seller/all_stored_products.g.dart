// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_stored_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllStoredProducts _$AllStoredProductsFromJson(Map<String, dynamic> json) => AllStoredProducts(
      (json['products'] as List<dynamic>).map((e) => Product.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$AllStoredProductsToJson(AllStoredProducts instance) => <String, dynamic>{
      'products': instance.products.map((e) => e.toJson()).toList(),
    };
