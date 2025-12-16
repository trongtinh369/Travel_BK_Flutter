import 'package:booking_tour_flutter/domain/trip.dart';

abstract class TripState {}

class TripInitial extends TripState {}

class TripLoading extends TripState {}

class TripLoaded extends TripState {
  final List<Trip> trips;
  TripLoaded(this.trips);
}

class TripError extends TripState {
  final String message;
  TripError(this.message);
}
