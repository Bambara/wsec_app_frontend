// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_buyer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupBuyer _$SignupBuyerFromJson(Map<String, dynamic> json) => SignupBuyer(
      json['id'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['user_name'] as String,
      json['email'] as String,
      json['mobile'] as String,
      Address.fromJson(json['address'] as Map<String, dynamic>),
      json['password'] as String,
      Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      json['role'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$SignupBuyerToJson(SignupBuyer instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'user_name': instance.user_name,
      'email': instance.email,
      'mobile': instance.mobile,
      'address': instance.address.toJson(),
      'password': instance.password,
      'avatar': instance.avatar.toJson(),
      'role': instance.role,
      'status': instance.status,
    };
