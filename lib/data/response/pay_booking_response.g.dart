// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayBookingResponse _$PayBookingResponseFromJson(Map<String, dynamic> json) =>
    PayBookingResponse(
      id: (json['id'] as num?)?.toInt(),
      numPeople: (json['numPeople'] as num?)?.toInt(),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      payType: json['payType'] as bool?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$PayBookingResponseToJson(PayBookingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'numPeople': instance.numPeople,
      'email': instance.email,
      'phone': instance.phone,
      'totalPrice': instance.totalPrice,
      'payType': instance.payType,
      'code': instance.code,
    };
