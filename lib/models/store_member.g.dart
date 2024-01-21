// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreMember _$StoreMemberFromJson(Map<String, dynamic> json) => StoreMember(
      json['id'] as String,
      json['type'] as String,
      json['status'] as String,
      json['time_stamp'] as String,
      json['store_id'] as String,
      json['profile_id'] as String,
    );

Map<String, dynamic> _$StoreMemberToJson(StoreMember instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'status': instance.status,
      'time_stamp': instance.time_stamp,
      'store_id': instance.store_id,
      'profile_id': instance.profile_id,
    };
