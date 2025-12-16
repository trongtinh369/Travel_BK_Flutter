import 'package:booking_tour_flutter/domain/bank.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BankResponse {
  int? id;
  String? name;

  BankResponse({this.id, this.name});

  factory BankResponse.fromJson(Map<String, dynamic> json) =>
      _$BankResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BankResponseToJson(this);
}

extension BankResponseMapper on BankResponse {
  Bank map() {
    return Bank(
      id: id ?? 0,
      name: name ?? "",
    );
  }
}
