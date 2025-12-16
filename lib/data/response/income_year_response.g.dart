// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_year_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeYearItem _$IncomeYearItemFromJson(Map<String, dynamic> json) =>
    IncomeYearItem(
      year: json['year'] as String,
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$IncomeYearItemToJson(IncomeYearItem instance) =>
    <String, dynamic>{'year': instance.year, 'value': instance.value};

IncomeYearResponse _$IncomeYearResponseFromJson(Map<String, dynamic> json) =>
    IncomeYearResponse(
      data:
          (json['data'] as List<dynamic>)
              .map((e) => IncomeYearItem.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$IncomeYearResponseToJson(IncomeYearResponse instance) =>
    <String, dynamic>{'data': instance.data};
