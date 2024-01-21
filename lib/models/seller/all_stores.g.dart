// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_stores.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllStores _$AllStoresFromJson(Map<String, dynamic> json) => AllStores(
      (json['stores'] as List<dynamic>).map((e) => StoreResponse.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$AllStoresToJson(AllStores instance) => <String, dynamic>{
      'stores': instance.stores.map((e) => e.toJson()).toList(),
    };
