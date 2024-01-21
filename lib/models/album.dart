import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable(explicitToJson: true)
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
