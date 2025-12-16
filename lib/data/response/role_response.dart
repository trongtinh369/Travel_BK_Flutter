import 'package:booking_tour_flutter/domain/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_response.g.dart';

@JsonSerializable()
class RoleResponse {
  int? id;
  String? title;

  RoleResponse({this.id, this.title});

  factory RoleResponse.fromJson(Map<String, dynamic> json) =>
      _$RoleResponseFromJson(json);
}

extension RoleResponseMapper on RoleResponse {
  Role map() {
    return Role(id: id ?? 0, title: title ?? '');
  }
}
