import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:equatable/equatable.dart';

abstract class HoatDongState extends Equatable {
  const HoatDongState();

  @override
  List<Object?> get props => [];
}

class HoatDongInitial extends HoatDongState {}

class HoatDongLoading extends HoatDongState {}

class HoatDongLoaded extends HoatDongState {
  final List<Activity> activities;
  final bool isLoading;
  final String? error;

  const HoatDongLoaded({
    required this.activities,
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object?> get props => [activities, isLoading, error];

  HoatDongLoaded copyWith({
    List<Activity>? activities,
    bool? isLoading,
    String? error,
  }) {
    return HoatDongLoaded(
      activities: activities ?? this.activities,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class HoatDongError extends HoatDongState {
  final String message;

  const HoatDongError({required this.message});

  @override
  List<Object?> get props => [message];
}

class HoatDongAdding extends HoatDongState {
  final List<Activity> activities;

  const HoatDongAdding({required this.activities});

  @override
  List<Object?> get props => [activities];
}

class HoatDongEditing extends HoatDongState {
  final List<Activity> activities;

  const HoatDongEditing({required this.activities});

  @override
  List<Object?> get props => [activities];
}

class HoatDongSuccess extends HoatDongState {
  final String message;
  final List<Activity> activities;

  const HoatDongSuccess({required this.message, required this.activities});

  @override
  List<Object?> get props => [message, activities];
}
