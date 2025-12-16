import 'package:booking_tour_flutter/data/response/province_response.dart';
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/domain/province.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaceResponse {
  int? id;
  String? name;
  ProvinceResponse? location;

  PlaceResponse({this.id, this.name, this.location});

  factory PlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceResponseToJson(this);
}

extension PlaceResponseMapper on PlaceResponse {
  Place map() {
    return Place(
      id: id ?? 0,
      name: name ?? "",
      province: location?.map() ?? Province(id: 0, name: ""),
    );
  }
}
