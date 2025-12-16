import 'package:booking_tour_flutter/domain/province.dart';
import 'package:json_annotation/json_annotation.dart';

part 'province_response.g.dart';

@JsonSerializable()
class ProvinceResponse {
  int? id;
  String? name;
  ProvinceResponse({this.id, this.name});

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) =>
      _$ProvinceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProvinceResponseToJson(this);
}

extension ProvinceResponseMapper on ProvinceResponse {
  Province map() {
    return Province(id: id ?? 0, name: name ?? "");
  }
}
