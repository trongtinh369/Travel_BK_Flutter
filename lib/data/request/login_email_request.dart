// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'login_email_request.g.dart';

@JsonSerializable()
class LoginEmailRequest {
  final String email;
  final String name;
  final String photoUrl;
  final String token;

  LoginEmailRequest({
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.token
  });

  Map<String, dynamic> toJson() => _$LoginEmailRequestToJson(this);  
}
