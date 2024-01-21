// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_stock_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllStockProducts _$AllStockProductsFromJson(Map<String, dynamic> json) => AllStockProducts(
      (json['stock'] as List<dynamic>).map((e) => StockProduct.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$AllStockProductsToJson(AllStockProducts instance) => <String, dynamic>{
      'stock': instance.stock.map((e) => e.toJson()).toList(),
    };
