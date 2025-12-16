import 'package:booking_tour_flutter/data/response/user_response.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final int roleId;
  final int money;
  final String bankNumber;
  final String bank;
  final String name;
  final String email;
  final String phone;
  final String avatarPath;
  final String bankBranch;
  final bool refundStatus;

  User({
    required this.id,
    required this.roleId,
    required this.money,
    required this.bankNumber,
    required this.bank,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarPath,
    required this.bankBranch,
    required this.refundStatus,
  });

  static User empty() {
    return User(
      id: 0,
      roleId: 0,
      money: 0,
      bankNumber: '',
      bank: '',
      name: '',
      email: '',
      phone: '',
      avatarPath:
          'https://photo.znews.vn/w1920/Uploaded/mdf_eioxrd/2021_07_06/1q.jpg',
      bankBranch: '',
      refundStatus: false,
    );
  }

  @override
  List<Object?> get props => [id];
}

extension UserExtension on User {
  UserResponse toResponse() {
    return UserResponse(
      id: id,
      roleId: roleId,
      money: money,
      bankNumber: bankNumber,
      bank: bank,
      name: name,
      email: email,
      phone: phone,
      avatarPath: avatarPath,
      bankBranch: bankBranch,
    );
  }
}
