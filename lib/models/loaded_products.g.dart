// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loaded_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadedProducts _$LoadedProductsFromJson(Map<String, dynamic> json) => LoadedProducts(
      json['supplier'] as String,
      json['fullName'] as String,
      json['address'] as String,
      json['postalCode'] as String,
      json['city'] as String,
      json['country'] as String,
      (json['items'] as List<dynamic>).map((e) => GRNProduct.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$LoadedProductsToJson(LoadedProducts instance) => <String, dynamic>{
      'supplier': instance.supplier,
      'fullName': instance.fullName,
      'address': instance.address,
      'postalCode': instance.postalCode,
      'city': instance.city,
      'country': instance.country,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
