// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/province.dart';
import 'package:equatable/equatable.dart';

class Place extends Equatable {
  int id;
  String name;
  Province province;

  Place({required this.id, required this.name, required this.province});

  @override
  List<Object?> get props => [id, name, province];
}
