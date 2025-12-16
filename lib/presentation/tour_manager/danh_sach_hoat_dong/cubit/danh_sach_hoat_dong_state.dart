import 'package:booking_tour_flutter/domain/location_activity.dart';
import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:equatable/equatable.dart';

enum DanhSachHoatDongStatus { initial, loading, success, failure }

class DanhSachHoatDongState extends Equatable {
  final List<LocationActivity> danhSachHoatDong;
  final List<LocationActivity> originalDanhSachHoatDong;
  final DanhSachHoatDongStatus status;
  final String? error;
  final LocationActivity? selectedLocationActivity;
  final List<Activity> activities;
  final List<Activity> filteredActivities;
  final String searchQuery;
  final int? placeId;

  const DanhSachHoatDongState({
    this.danhSachHoatDong = const [],
    this.originalDanhSachHoatDong = const [],
    this.status = DanhSachHoatDongStatus.initial,
    this.error,
    this.selectedLocationActivity,
    this.activities = const [],
    this.filteredActivities = const [],
    this.searchQuery = '',
    this.placeId,
  });

  DanhSachHoatDongState copyWith({
    List<LocationActivity>? danhSachHoatDong,
    List<LocationActivity>? originalDanhSachHoatDong,
    DanhSachHoatDongStatus? status,
    String? error,
    LocationActivity? selectedLocationActivity,
    List<Activity>? activities,
    List<Activity>? filteredActivities,
    String? searchQuery,
    int? placeId,
  }) {
    return DanhSachHoatDongState(
      danhSachHoatDong: danhSachHoatDong ?? this.danhSachHoatDong,
      originalDanhSachHoatDong: originalDanhSachHoatDong ?? this.originalDanhSachHoatDong,
      status: status ?? this.status,
      error: error ?? this.error,
      selectedLocationActivity: selectedLocationActivity ?? this.selectedLocationActivity,
      activities: activities ?? this.activities,
      filteredActivities: filteredActivities ?? this.filteredActivities,
      searchQuery: searchQuery ?? this.searchQuery,
      placeId: placeId ?? this.placeId,
    );
  }

  @override
  List<Object?> get props => [danhSachHoatDong, originalDanhSachHoatDong, status, error, selectedLocationActivity, activities, filteredActivities, searchQuery, placeId];
}
