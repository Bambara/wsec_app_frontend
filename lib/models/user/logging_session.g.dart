// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logging_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggingSession _$LoggingSessionFromJson(Map<String, dynamic> json) => LoggingSession(
      json['_id'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['email'] as String,
      json['role'] as String,
      json['token'] as String,
    );

Map<String, dynamic> _$LoggingSessionToJson(LoggingSession instance) => <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'role': instance.role,
      'token': instance.token,
    };
