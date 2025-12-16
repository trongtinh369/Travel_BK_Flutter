import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  String email;
  String newPassword;

  ChangePasswordRequest({
    required this.email,
    required this.newPassword,
  });
  
  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
