import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:equatable/equatable.dart';

class SuaHoatDongState extends Equatable {
  final bool status;
  final String? error;
  final List<Activity> activities;
  final List<Activity> filteredActivities;
  final List<Activity> selectedActivities;
  final String searchQuery;

  const SuaHoatDongState({
    this.status = false,
    this.error,
    this.activities = const [],
    this.filteredActivities = const [],
    this.selectedActivities = const [],
    this.searchQuery = '',
  });

  SuaHoatDongState copyWith({
    bool? status,
    String? error,
    List<Activity>? activities,
    List<Activity>? filteredActivities,
    List<Activity>? selectedActivities,
    String? searchQuery,
  }) {
    return SuaHoatDongState(
      status: status ?? this.status,
      error: error ?? this.error,
      activities: activities ?? this.activities,
      filteredActivities: filteredActivities ?? this.filteredActivities,
      selectedActivities: selectedActivities ?? this.selectedActivities,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [status, error, activities, filteredActivities, selectedActivities, searchQuery];
}

