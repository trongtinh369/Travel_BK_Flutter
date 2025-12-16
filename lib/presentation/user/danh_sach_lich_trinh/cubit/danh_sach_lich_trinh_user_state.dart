import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:equatable/equatable.dart';

class DanhSachLichTrinhUserState extends Equatable {
  final List<ScheduleTourmanager> schedules;
  final bool isLoading;

  const DanhSachLichTrinhUserState({
    this.schedules = const [],
    this.isLoading = true,
  });

  DanhSachLichTrinhUserState copyWith({
    List<ScheduleTourmanager>? schedules,
    bool? isLoading,
  }) {
    return DanhSachLichTrinhUserState(
      schedules: schedules ?? this.schedules,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [schedules, isLoading];
}
