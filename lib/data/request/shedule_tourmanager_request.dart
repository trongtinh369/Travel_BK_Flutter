
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
part 'shedule_tourmanager_request.g.dart';
@JsonSerializable()
class DeleteSheduleTourManagerRequest {
  final int id ; 
  DeleteSheduleTourManagerRequest({required this.id});
  factory DeleteSheduleTourManagerRequest.fromJson(Map<String, dynamic> json) =>
  _$DeleteSheduleTourManagerRequestFromJson(json);
  Map<String,dynamic> toJson() => _$DeleteSheduleTourManagerRequestToJson(this); 
}