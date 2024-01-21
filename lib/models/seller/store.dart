import 'package:json_annotation/json_annotation.dart';
import 'package:wsec_app_frontend/models/user/avatar.dart';

import '../common/address.dart';
import '../common/contact.dart';
import '../common/location.dart';

part 'store.g.dart';

@JsonSerializable(explicitToJson: true)
class Store {
  @JsonKey(name: '_id')
  String id;
  String name;
  Address address;
  Contact contact;
  String status;
  Location location;
  Avatar avatar;
  String type;

  Store(this.id, this.name, this.address, this.contact, this.status, this.location, this.avatar, this.type);

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
