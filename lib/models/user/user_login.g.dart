// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLogin _$UserLoginFromJson(Map<String, dynamic> json) => UserLogin(
      json['id'] as String,
      json['user_name'] as String,
      json['email'] as String,
      json['mobile_num'] as String,
      json['password'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$UserLoginToJson(UserLogin instance) => <String, dynamic>{
      'id': instance.id,
      'user_name': instance.user_name,
      'email': instance.email,
      'mobile_num': instance.mobile_num,
      'password': instance.password,
      'status': instance.status,
    };
