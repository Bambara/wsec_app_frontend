import 'package:json_annotation/json_annotation.dart';
import 'package:wsec_app_frontend/models/seller/store_response.dart';

part 'all_stores.g.dart';

@JsonSerializable(explicitToJson: true)
class AllStores {
  List<StoreResponse> stores;

  AllStores(this.stores);

  factory AllStores.fromJson(Map<String, dynamic> json) => _$AllStoresFromJson(json);

  Map<String, dynamic> toJson() => _$AllStoresToJson(this);
}
