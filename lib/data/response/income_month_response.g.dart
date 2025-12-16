// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_month_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeMonthData _$IncomeMonthDataFromJson(Map<String, dynamic> json) =>
    IncomeMonthData(
      january: (json['january'] as num).toInt(),
      february: (json['february'] as num).toInt(),
      march: (json['march'] as num).toInt(),
      april: (json['april'] as num).toInt(),
      may: (json['may'] as num).toInt(),
      june: (json['june'] as num).toInt(),
      july: (json['july'] as num).toInt(),
      august: (json['august'] as num).toInt(),
      september: (json['september'] as num).toInt(),
      october: (json['october'] as num).toInt(),
      november: (json['november'] as num).toInt(),
      december: (json['december'] as num).toInt(),
    );

Map<String, dynamic> _$IncomeMonthDataToJson(IncomeMonthData instance) =>
    <String, dynamic>{
      'january': instance.january,
      'february': instance.february,
      'march': instance.march,
      'april': instance.april,
      'may': instance.may,
      'june': instance.june,
      'july': instance.july,
      'august': instance.august,
      'september': instance.september,
      'october': instance.october,
      'november': instance.november,
      'december': instance.december,
    };

IncomeMonthResponse _$IncomeMonthResponseFromJson(Map<String, dynamic> json) =>
    IncomeMonthResponse(
      data: IncomeMonthData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IncomeMonthResponseToJson(
  IncomeMonthResponse instance,
) => <String, dynamic>{'data': instance.data};
