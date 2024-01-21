import 'package:json_annotation/json_annotation.dart';

part 'store_member.g.dart';

@JsonSerializable(explicitToJson: true)
class StoreMember {
  String id;
  String type;
  String status;
  String time_stamp;
  String store_id;
  String profile_id;

  StoreMember(this.id, this.type, this.status, this.time_stamp, this.store_id, this.profile_id);

  factory StoreMember.fromJson(Map<String, dynamic> json) => _$StoreMemberFromJson(json);

  Map<String, dynamic> toJson() => _$StoreMemberToJson(this);
}
