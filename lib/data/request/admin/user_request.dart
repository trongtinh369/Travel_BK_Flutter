import 'package:json_annotation/json_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest {
  int roleId;
  String password;
  int money;
  String bankNumber;
  String bank;
  String name;
  String email;
  String phone;
  String avatarPath;
  String bankBranch;
  String token;

  UserRequest({
    required this.roleId,
    required this.password,
    required this.money,
    required this.bankNumber,
    required this.bank,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarPath,
    required this.bankBranch,
    required this.token,
  });
  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}
