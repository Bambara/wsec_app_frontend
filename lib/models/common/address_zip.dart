import 'package:json_annotation/json_annotation.dart';

part 'address_zip.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressZip {
  // String id;
  String line_01;
  String line_02;
  String city;
  String state;
  String country;

  AddressZip(this.line_01, this.line_02, this.city, this.state, this.country);

  factory AddressZip.fromJson(Map<String, dynamic> json) => _$AddressZipFromJson(json);

  Map<String, dynamic> toJson() => _$AddressZipToJson(this);
}
