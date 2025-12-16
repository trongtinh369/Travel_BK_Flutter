import 'package:bloc/bloc.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/participants.dart';
import 'package:booking_tour_flutter/presentation/tour_guide/cubit/participants_state.dart';

class ParticipantsCubit extends Cubit<ParticipantsState> {
  final BookingRepository _repository = getIt<BookingRepository>();

  ParticipantsCubit() : super(ParticipantsInitial());

  Future<void> loadParticipants(int scheduleId, String scheduleCode, DateTime startDate, DateTime endDate) async {
    emit(ParticipantsLoading());

    final result = await _repository.getParticipantsByScheduleId(scheduleId: scheduleId);

    result.fold(
      (failure) => emit(ParticipantsError(failure.message)),
      (participants) => emit(ParticipantsLoaded(
        participants: participants,
        scheduleCode: scheduleCode,
        startDate: startDate,
        endDate: endDate,
      )),
    );
  }
}