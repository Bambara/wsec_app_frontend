import 'package:json_annotation/json_annotation.dart';
import 'package:wsec_app_frontend/models/seller/store_response.dart';

part 'store_response_ob.g.dart';

@JsonSerializable(explicitToJson: true)
class StoreResponseOb {
  StoreResponse store;

  StoreResponseOb(this.store);

  factory StoreResponseOb.fromJson(Map<String, dynamic> json) => _$StoreResponseObFromJson(json);

  Map<String, dynamic> toJson() => _$StoreResponseObToJson(this);
}
