// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      json['_id'] as String,
      json['name'] as String,
      Address.fromJson(json['address'] as Map<String, dynamic>),
      Contact.fromJson(json['contact'] as Map<String, dynamic>),
      json['status'] as String,
      Location.fromJson(json['location'] as Map<String, dynamic>),
      Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      json['type'] as String,
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'address': instance.address.toJson(),
      'contact': instance.contact.toJson(),
      'status': instance.status,
      'location': instance.location.toJson(),
      'avatar': instance.avatar.toJson(),
      'type': instance.type,
    };
