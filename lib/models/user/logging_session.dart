import 'package:json_annotation/json_annotation.dart';

part 'logging_session.g.dart';

@JsonSerializable(explicitToJson: true)
class LoggingSession {
  @JsonKey(name: '_id')
  String id;
  String first_name;
  String last_name;
  String email;
  String role;
  String token;

  LoggingSession(this.id, this.first_name, this.last_name, this.email, this.role, this.token);

  factory LoggingSession.fromJson(Map<String, dynamic> json) => _$LoggingSessionFromJson(json);

  Map<String, dynamic> toJson() => _$LoggingSessionToJson(this);
}
