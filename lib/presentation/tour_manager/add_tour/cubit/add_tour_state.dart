// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:booking_tour_flutter/domain/trip.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/validate_state.dart';
import 'package:dartz/dartz.dart';

import 'package:booking_tour_flutter/domain/create_tour/CT_day_of_tour.dart';
import 'package:booking_tour_flutter/domain/create_tour/CT_tour.dart';
import 'package:booking_tour_flutter/domain/province.dart';

class AddTourState {
  final int? id;
  final CTTour tour;
  final List<CTDayOfTour> daysOfTour;
  final int selectedDayOfTour;
  final List<Province> provinces;
  final List<Either<File, String>> images;
  late final ValidateState validateState;

  AddTourState({
    this.id,
    required this.tour,
    required this.daysOfTour,
    required this.selectedDayOfTour,
    required this.provinces,
    required this.images,
    ValidateState? validateState,
  }) {
    this.validateState =
        validateState ?? ValidateState(errors: {}, isValidated: false);
  }

  AddTourState copyWith({
    int? id,
    CTTour? tour,
    List<CTDayOfTour>? daysOfTour,
    int? selectedDayOfTour,
    List<Province>? provinces,
    List<Either<File, String>>? images,
    ValidateState? validateState,
  }) {
    return AddTourState(
      id: id ?? this.id,
      tour: tour ?? this.tour,
      daysOfTour: daysOfTour ?? this.daysOfTour,
      selectedDayOfTour: selectedDayOfTour ?? this.selectedDayOfTour,
      provinces: provinces ?? this.provinces,
      images: images ?? this.images,
      validateState: validateState ?? this.validateState,
    );
  }

  String? getErrorMessage(String key) {
    return validateState.errors[key];
  }

  bool get isValidated => validateState.isValidated;
}

extension TripToStateMapper on Trip {
  AddTourState toAddTourState() {
    var tour = this.mapToCTTour();
    var daysOfTour = this.dayOfTours.map((i) => i.mapToCTDayOfTour()).toList();
    var images = this.tourImages.map((i) => right<File, String>(i)).toList();

    return AddTourState(
      id: this.id,
      tour: tour,
      daysOfTour: daysOfTour,
      selectedDayOfTour: 0,
      provinces: provinces,
      images: images,
    );
  }
}
