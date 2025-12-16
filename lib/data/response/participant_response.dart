import 'package:booking_tour_flutter/data/response/booking_response.dart';
import 'package:booking_tour_flutter/domain/participants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'participant_response.g.dart';

@JsonSerializable()
class ActualcashData {
  final int? id;
  final int? money;
  final int? bookingId;
  final String? createdAt;

  ActualcashData({
    this.id,
    this.money,
    this.bookingId,
    this.createdAt,
  });

  factory ActualcashData.fromJson(Map<String, dynamic> json) =>
      _$ActualcashDataFromJson(json);

  Map<String, dynamic> toJson() => _$ActualcashDataToJson(this);
}

@JsonSerializable()
class UserCompletedScheduleResponse {
  final int? countPeople;
  final ActualcashData? actualcashs;
  final BookingResponse? booking;

  UserCompletedScheduleResponse({
    this.countPeople,
    this.actualcashs,
    this.booking,
  });

  factory UserCompletedScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$UserCompletedScheduleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserCompletedScheduleResponseToJson(this);
}

extension UserCompletedScheduleMapper on UserCompletedScheduleResponse {
  Participant? mapToParticipant() {
    if (booking == null || booking!.user == null) {
      return null;
    }

    final user = booking!.user!;
    String avatar = user.avatarPath ?? "";

    // Fix avatar URL
    if (avatar.isNotEmpty && !avatar.startsWith('http')) {
      avatar = "http://tt1220-001-site1.ntempurl.com$avatar";
    }
    if (avatar.isEmpty) {
      avatar = "https://ui-avatars.com/api/?name=${Uri.encodeComponent(user.name ?? 'User')}&background=random";
    }

    return Participant(
      name: user.name ?? "Unknown",
      quantity: booking!.numPeople ?? 0,
      phoneNumber: booking!.phone ?? "N/A",
      avatarPath: avatar,
    );
  }
}
