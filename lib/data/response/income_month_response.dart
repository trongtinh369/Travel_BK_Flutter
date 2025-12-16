import 'package:booking_tour_flutter/domain/income_month.dart';
import 'package:json_annotation/json_annotation.dart';

part 'income_month_response.g.dart';

@JsonSerializable()
class IncomeMonthData {
  final int january;
  final int february;
  final int march;
  final int april;
  final int may;
  final int june;
  final int july;
  final int august;
  final int september;
  final int october;
  final int november;
  final int december;

  IncomeMonthData({
    required this.january,
    required this.february,
    required this.march,
    required this.april,
    required this.may,
    required this.june,
    required this.july,
    required this.august,
    required this.september,
    required this.october,
    required this.november,
    required this.december,
  });

  factory IncomeMonthData.fromJson(Map<String, dynamic> json) =>
      _$IncomeMonthDataFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeMonthDataToJson(this);

  IncomeMonth map() {
    return IncomeMonth(
      january: january,
      february: february,
      march: march,
      april: april,
      may: may,
      june: june,
      july: july,
      august: august,
      september: september,
      october: october,
      november: november,
      december: december,
    );
  }
}

@JsonSerializable()
class IncomeMonthResponse {
  final IncomeMonthData data;

  IncomeMonthResponse({required this.data});

  factory IncomeMonthResponse.fromJson(Map<String, dynamic> json) =>
      _$IncomeMonthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeMonthResponseToJson(this);

  IncomeMonth map() => data.map();
}
