import 'package:json_annotation/json_annotation.dart';
import 'package:wsec_app_frontend/models/user/avatar.dart';

import '../common/address.dart';
import '../common/contact.dart';
import '../common/location.dart';

part 'store_response.g.dart';

@JsonSerializable(explicitToJson: true)
class StoreResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  Address address;
  Contact contact;
  String status;
  Location location;
  Avatar avatar;
  String type;

  StoreResponse(this.name, this.address, this.contact, this.status, this.location, this.avatar, this.type, this.id);

  factory StoreResponse.fromJson(Map<String, dynamic> json) => _$StoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}
