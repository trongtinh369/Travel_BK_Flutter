import 'package:booking_tour_flutter/domain/notification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  int? id;
  int? userId;
  String? content;
  bool? isRead;
  DateTime? createdAt;

  NotificationResponse({
    this.id,
    this.userId,
    this.content,
    this.isRead,
    this.createdAt,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}

extension NotificationResponseMapper on NotificationResponse {
  Notification map() {
    return Notification(
      id: id ?? 0,
      userId: userId ?? 0,
      content: content ?? '',
      isRead: isRead ?? false,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}
