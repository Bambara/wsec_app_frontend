import 'package:json_annotation/json_annotation.dart';

part 'avatar_p.g.dart';

@JsonSerializable(explicitToJson: true)
class AvatarP {
  String id;
  String name;
  String url;

  AvatarP(this.id, this.name, this.url);

  factory AvatarP.fromJson(Map<String, dynamic> json) => _$AvatarPFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarPToJson(this);
}
