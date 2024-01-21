import 'package:json_annotation/json_annotation.dart';

import '../common/address.dart';
import 'avatar.dart';

part 'signup_buyer.g.dart';

@JsonSerializable(explicitToJson: true)
class SignupBuyer {
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

  SignupBuyer(this.id, this.first_name, this.last_name, this.user_name, this.email, this.mobile, this.address, this.password, this.avatar, this.role, this.status);

  factory SignupBuyer.fromJson(Map<String, dynamic> json) => _$SignupBuyerFromJson(json);

  Map<String, dynamic> toJson() => _$SignupBuyerToJson(this);
}
