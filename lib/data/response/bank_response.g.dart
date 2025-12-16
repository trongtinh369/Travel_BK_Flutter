// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankResponse _$BankResponseFromJson(Map<String, dynamic> json) => BankResponse(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
);

Map<String, dynamic> _$BankResponseToJson(BankResponse instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
