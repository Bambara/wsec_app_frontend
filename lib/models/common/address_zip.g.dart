// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_zip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressZip _$AddressZipFromJson(Map<String, dynamic> json) => AddressZip(
      json['line_01'] as String,
      json['line_02'] as String,
      json['city'] as String,
      json['state'] as String,
      json['country'] as String,
    );

Map<String, dynamic> _$AddressZipToJson(AddressZip instance) => <String, dynamic>{
      'line_01': instance.line_01,
      'line_02': instance.line_02,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };
