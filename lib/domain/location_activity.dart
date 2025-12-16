// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:equatable/equatable.dart';

class LocationActivity extends Equatable{
  int id;
  String name;
  Place place;
  List<Activity> activities;

  LocationActivity({required this.id, required this.name, required this.place, required this.activities});
  
  @override
  List<Object?> get props => [id, name, place];
}
