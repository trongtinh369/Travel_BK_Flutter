import 'package:booking_tour_flutter/data/request/tour_guide/tour_guide_request.dart';
import 'package:booking_tour_flutter/domain/user.dart';

class TourGuide {
  final int userId;
  final String code;
  final bool isActive;
  final String cccd;
  final String address;
  final DateTime dateOfBirth;
  final DateTime startWorkingDate;
  final DateTime cccdIssueDate;
  final String cccdFrontPath;
  final String cccBackPath;
  final DateTime endWorkingDate;

  bool ischecked;
  final User user;

  TourGuide({
    required this.userId,
    required this.code,
    required this.isActive,
    required this.cccd,
    required this.address,
    required this.dateOfBirth,
    required this.startWorkingDate,
    required this.cccdIssueDate,
    required this.cccdFrontPath,
    required this.cccBackPath,
    required this.endWorkingDate,
    required this.ischecked,
    required this.user,
  });

  TourGuide copyWith({
    int? userId,
    String? code,
    bool? isActive,
    String? cccd,
    String? address,
    DateTime? dateOfBirth,
    DateTime? startWorkingDate,
    DateTime? cccdIssueDate,
    String? cccdFrontPath,
    String? cccBackPath,
    DateTime? endWorkingDate,
    bool? ischecked,
    User? user,
  }) {
    return TourGuide(
      userId: userId ?? this.userId,
      code: code ?? this.code,
      isActive: isActive ?? this.isActive,
      cccd: cccd ?? this.cccd,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      startWorkingDate: startWorkingDate ?? this.startWorkingDate,
      cccdIssueDate: cccdIssueDate ?? this.cccdIssueDate,
      cccdFrontPath: cccdFrontPath ?? this.cccdFrontPath,
      cccBackPath: cccBackPath ?? this.cccBackPath,
      endWorkingDate: endWorkingDate ?? this.endWorkingDate,
      ischecked: ischecked ?? this.ischecked,
      user: user ?? this.user,
    );
  }

  static TourGuide empty() {
    return TourGuide(
      userId: 0,
      code: '',
      isActive: false,
      cccd: '',
      address: '',
      dateOfBirth: DateTime.now(),
      startWorkingDate: DateTime.now(),
      cccdIssueDate: DateTime.now(),
      cccdFrontPath: '',
      cccBackPath: '',
      endWorkingDate: DateTime.now(),
      ischecked: false,
      user: User.empty(),
    );
  }
}

extension TourGuideExtension on TourGuide {
  TourGuideRequest toRequest() {
    return TourGuideRequest(
      userId: userId,
      ischecked: ischecked,
    );
  }
}
