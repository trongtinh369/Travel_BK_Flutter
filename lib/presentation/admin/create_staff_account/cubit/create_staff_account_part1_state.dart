import 'package:flutter/foundation.dart';

@immutable
class CreateStaffAccountPart1State {
  final String? account;
  final String? password;
  final String? name;
  final String? cccd;
  final String? issuedDate;
  final String? email;
  final String? phone;
  final String? address;
  final String? dob;
  final String? startDate;
  final String? selectedRole;
  final int? roleId;
  final String? avatarPath;

  const CreateStaffAccountPart1State({
    this.account,
    this.password,
    this.name,
    this.cccd,
    this.issuedDate,
    this.email,
    this.phone,
    this.address,
    this.dob,
    this.startDate,
    this.selectedRole,
    this.roleId,
    this.avatarPath,
  });

  CreateStaffAccountPart1State copyWith({
    String? account,
    String? password,
    String? name,
    String? cccd,
    String? issuedDate,
    String? email,
    String? phone,
    String? address,
    String? dob,
    String? startDate,
    String? selectedRole,
    int? roleId,
    String? avatarPath,
  }) {
    return CreateStaffAccountPart1State(
      account: account ?? this.account,
      password: password ?? this.password,
      name: name ?? this.name,
      cccd: cccd ?? this.cccd,
      issuedDate: issuedDate ?? this.issuedDate,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      dob: dob ?? this.dob,
      startDate: startDate ?? this.startDate,
      selectedRole: selectedRole ?? this.selectedRole,
      roleId: roleId ?? this.roleId,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}

