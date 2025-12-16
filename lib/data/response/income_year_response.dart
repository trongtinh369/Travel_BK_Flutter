import 'package:booking_tour_flutter/domain/income_year.dart';
import 'package:json_annotation/json_annotation.dart';

part 'income_year_response.g.dart';

@JsonSerializable()
class IncomeYearItem {
  final String year;
  final int value;

  IncomeYearItem({
    required this.year,
    required this.value,
  });

  factory IncomeYearItem.fromJson(Map<String, dynamic> json) =>
      _$IncomeYearItemFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeYearItemToJson(this);

  // Map từ Response sang Domain Model
  IncomeYear map() {
    return IncomeYear(
      year: year,
      value: value,
    );
  }
}

@JsonSerializable()
class IncomeYearResponse {
  final List<IncomeYearItem> data;

  IncomeYearResponse({required this.data});

  factory IncomeYearResponse.fromJson(Map<String, dynamic> json) =>
      _$IncomeYearResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeYearResponseToJson(this);

  List<IncomeYear> mapToList() {
    return data.map((item) => item.map()).toList();
  }
}