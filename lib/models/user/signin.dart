import 'package:json_annotation/json_annotation.dart';

part 'signin.g.dart';

@JsonSerializable(explicitToJson: true)
class Signin {
  String email;
  String password;

  Signin(this.email, this.password);

  factory Signin.fromJson(Map<String, dynamic> json) => _$SigninFromJson(json);

  Map<String, dynamic> toJson() => _$SigninToJson(this);
}
