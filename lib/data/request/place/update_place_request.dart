import 'package:booking_tour_flutter/data/response/province_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_place_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdatePlaceRequestData {
  int? id;
  String? name;
  ProvinceResponse? location;

  UpdatePlaceRequestData({this.id, this.name, this.location});

  Map<String, dynamic> toJson() => _$UpdatePlaceRequestDataToJson(this);
}