import 'package:json_annotation/json_annotation.dart';

import '../common/address.dart';
import '../seller/store.dart';
import 'avatar.dart';

part 'signup_seller.g.dart';

@JsonSerializable(explicitToJson: true)
class SignupSeller {
  final String id;
  final String first_name;
  final String last_name;
  final String user_name;
  final String email;
  final String mobile;
  final Address address;
  final String password;
  final Avatar avatar;
  final String role;
  final String status;
  final Store store;

  SignupSeller(
      this.id, this.first_name, this.last_name, this.user_name, this.email, this.mobile, this.address, this.password, this.avatar, this.role, this.status, this.store);

  factory SignupSeller.fromJson(Map<String, dynamic> json) => _$SignupSellerFromJson(json);

  Map<String, dynamic> toJson() => _$SignupSellerToJson(this);
}
