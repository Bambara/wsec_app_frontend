// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Business _$BusinessFromJson(Map<String, dynamic> json) => Business(
      json['_id'] as String,
      json['name'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['__v'] as int,
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      '__v': instance.v,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
