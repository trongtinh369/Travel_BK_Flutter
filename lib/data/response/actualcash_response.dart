import 'package:booking_tour_flutter/domain/actualcash.dart';
import 'package:json_annotation/json_annotation.dart';

part 'actualcash_response.g.dart';

@JsonSerializable()
class ActualcashResponse {
  final int? id;
  final int? money;
  final int? bookingId;
  final DateTime? createdAt;

  ActualcashResponse({
    this.id,
    this.money,
    this.bookingId,
    this.createdAt
  });
  factory ActualcashResponse.fromJson(Map<String, dynamic> json) =>
      _$ActualcashResponseFromJson(json);
}

extension ActualcashResponseMapper on ActualcashResponse{
  Actualcash map(){
    return Actualcash.empty();
  }
}