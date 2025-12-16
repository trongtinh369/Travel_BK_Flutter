// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingResponse _$BookingResponseFromJson(Map<String, dynamic> json) =>
    BookingResponse(
        numPeople: (json['numPeople'] as num?)?.toInt(),
        code: json['code'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        totalPrice: (json['totalPrice'] as num?)?.toInt(),
        countChangeLeft: (json['countChangeLeft'] as num?)?.toInt(),
        createdAt:
            json['createdAt'] == null
                ? null
                : DateTime.parse(json['createdAt'] as String),
        status:
            json['status'] == null
                ? null
                : BookingStatusResponse.fromJson(
                  json['status'] as Map<String, dynamic>,
                ),
        schedule:
            json['schedule'] == null
                ? null
                : ScheduleTourmanagerResponse.fromJson(
                  json['schedule'] as Map<String, dynamic>,
                ),
        user:
            json['user'] == null
                ? null
                : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      )
      ..id = (json['id'] as num?)?.toInt()
      ..payType = json['payType'] as bool?
      ..expiredAt =
          json['expiredAt'] == null
              ? null
              : DateTime.parse(json['expiredAt'] as String)
      ..qr = json['qr'] as String?;

Map<String, dynamic> _$BookingResponseToJson(BookingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'numPeople': instance.numPeople,
      'code': instance.code,
      'email': instance.email,
      'phone': instance.phone,
      'totalPrice': instance.totalPrice,
      'countChangeLeft': instance.countChangeLeft,
      'createdAt': instance.createdAt?.toIso8601String(),
      'payType': instance.payType,
      'status': instance.status,
      'schedule': instance.schedule,
      'user': instance.user,
      'expiredAt': instance.expiredAt?.toIso8601String(),
      'qr': instance.qr,
    };
