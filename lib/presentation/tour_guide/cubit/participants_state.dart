import 'package:booking_tour_flutter/domain/participants.dart';
import 'package:equatable/equatable.dart';

abstract class ParticipantsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ParticipantsInitial extends ParticipantsState {}

class ParticipantsLoading extends ParticipantsState {}

class ParticipantsLoaded extends ParticipantsState {
  final List<Participant> participants;
  final String scheduleCode;
  final DateTime startDate;
  final DateTime endDate;

  ParticipantsLoaded({
    required this.participants,
    required this.scheduleCode,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [participants, scheduleCode, startDate, endDate];
}

class ParticipantsError extends ParticipantsState {
  final String message;

  ParticipantsError(this.message);

  @override
  List<Object?> get props => [message];
}