import 'package:booking_tour_flutter/domain/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  int? id;
  int? roleId;
  int? money;
  String? bankNumber;
  String? bank;
  String? name;
  String? email;
  String? phone;
  String? avatarPath;
  String? bankBranch;
  bool? refundStatus;

  UserResponse({
    this.id,
    this.roleId,
    this.money,
    this.bankNumber,
    this.bank,
    this.name,
    this.email,
    this.phone,
    this.avatarPath,
    this.bankBranch,
    this.refundStatus
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

extension UserResponseMapper on UserResponse {
  User map() {
    return User(
      id: id ?? 0,
      roleId: roleId ?? 0,
      money: money ?? 0,
      bankNumber: bankNumber ?? "",
      bank: bank ?? "",
      name: name ?? "",
      email: email ?? "",
      phone: phone ?? "",
      avatarPath: avatarPath ?? "",
      bankBranch: bankBranch ?? "",
      refundStatus: refundStatus ?? false
    );
  }
}
