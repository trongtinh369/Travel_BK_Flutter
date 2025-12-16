import 'package:booking_tour_flutter/domain/role.dart';
import 'package:booking_tour_flutter/domain/user.dart';

class Staff {
  final int userId;
  final String code;
  final bool isActive;
  final String cccd;
  final String address;
  final DateTime dateOfBirth;
  final DateTime startWorkingDate;
  final DateTime cccdIssueDate;
  final String cccD_front_path;
  final String cccD_back_path;
  final DateTime endWorkingDate;

  final User user;
  final Role role;

  Staff({
    required this.userId,
    required this.code,
    required this.isActive,
    required this.cccd,
    required this.address,
    required this.dateOfBirth,
    required this.startWorkingDate,
    required this.cccdIssueDate,
    required this.cccD_front_path,
    required this.cccD_back_path,
    required this.endWorkingDate,
    required this.user,
    required this.role,
  });

  static Staff empty() {
    return Staff(
      userId: 0,
      code: '',
      isActive: false,
      cccd: '',
      address: '',
      dateOfBirth: DateTime.now(),
      startWorkingDate: DateTime.now(),
      cccdIssueDate: DateTime.now(),
      cccD_front_path: '',
      cccD_back_path: '',
      endWorkingDate: DateTime.now(),
      user: User.empty(),
      role: Role.empty(),
    );
  }

  Staff copyWith({
    int? userId,
    String? code,
    bool? isActive,
    String? cccd,
    String? address,
    DateTime? dateOfBirth,
    DateTime? startWorkingDate,
    DateTime? cccdIssueDate,
    String? cccD_front_path,
    String? cccD_back_path,
    DateTime? endWorkingDate,
    User? user,
    Role? role,
  }) {
    return Staff(
      userId: userId ?? this.userId,
      code: code ?? this.code,
      isActive: isActive ?? this.isActive,
      cccd: cccd ?? this.cccd,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      startWorkingDate: startWorkingDate ?? this.startWorkingDate,
      cccdIssueDate: cccdIssueDate ?? this.cccdIssueDate,
      cccD_front_path: cccD_front_path ?? this.cccD_front_path,
      cccD_back_path: cccD_back_path ?? this.cccD_back_path,
      endWorkingDate: endWorkingDate ?? this.endWorkingDate,
      user: user ?? this.user,
      role: role ?? this.role,
    );
  }
}
