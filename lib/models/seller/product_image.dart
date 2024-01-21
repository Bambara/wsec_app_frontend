import 'package:json_annotation/json_annotation.dart';

part 'product_image.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductImage {
  String id;
  String name;
  String image_url;

  ProductImage(this.id, this.name, this.image_url);

  factory ProductImage.fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}
