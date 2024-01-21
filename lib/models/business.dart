import 'package:json_annotation/json_annotation.dart';

part 'business.g.dart';

@JsonSerializable(explicitToJson: true)
class Business {
  @JsonKey(name: '_id')
  String id;
  String name;
  String email;
  String phone;
  @JsonKey(name: '__v')
  int v;
  String createdAt;
  String updatedAt;

  Business(this.id, this.name, this.email, this.phone, this.v, this.createdAt, this.updatedAt);

  factory Business.fromJson(Map<String, dynamic> json) => _$BusinessFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessToJson(this);
}
