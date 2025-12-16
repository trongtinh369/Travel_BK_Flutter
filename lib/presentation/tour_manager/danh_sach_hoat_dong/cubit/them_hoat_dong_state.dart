import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:equatable/equatable.dart';

enum ThemHoatDongStatus {
  initial,
  loading,
  loadingAdd,
  success,
  failure,
}

class ThemHoatDongState extends Equatable {
  final ThemHoatDongStatus status;
  final String? error;
  final List<Activity> activities;
  final List<Activity> filteredActivities;
  final String searchQuery;

  const ThemHoatDongState({
    this.status = ThemHoatDongStatus.initial,
    this.error,
    this.activities = const [],
    this.filteredActivities = const [],
    this.searchQuery = '',
  });

  ThemHoatDongState copyWith({
    ThemHoatDongStatus? status,
    String? error,
    List<Activity>? activities,
    List<Activity>? filteredActivities,
    String? searchQuery,
  }) {
    return ThemHoatDongState(
      status: status ?? this.status,
      error: error ?? this.error,
      activities: activities ?? this.activities,
      filteredActivities: filteredActivities ?? this.filteredActivities,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [status, error, activities, filteredActivities, searchQuery];
}
