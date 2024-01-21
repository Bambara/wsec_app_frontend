import 'package:json_annotation/json_annotation.dart';

part 'user_login.g.dart';

@JsonSerializable(explicitToJson: true)
class UserLogin {
  String id;
  String user_name;
  String email;
  String mobile_num;
  String password;
  String status;

  UserLogin(this.id, this.user_name, this.email, this.mobile_num, this.password, this.status);

  factory UserLogin.fromJson(Map<String, dynamic> json) => _$UserLoginFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginToJson(this);
}
