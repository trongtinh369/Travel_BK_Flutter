import 'package:json_annotation/json_annotation.dart';

part 'user_in_staff_update_request.g.dart';

@JsonSerializable()
class UserInStaffUpdateRequest {
  int id;
  int roleId;
  int money;
  String bankNumber;
  String bank;
  String name;
  String email;
  String phone;
  String bankBranch;
  String avatarPath;
  bool refundStatus;

  UserInStaffUpdateRequest({
    required this.id,
    required this.roleId,
    required this.money,
    required this.bankNumber,
    required this.bank,
    required this.name,
    required this.email,
    required this.phone,
    required this.bankBranch,
    required this.avatarPath,
    required this.refundStatus,
  });
  factory UserInStaffUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserInStaffUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserInStaffUpdateRequestToJson(this);
}
