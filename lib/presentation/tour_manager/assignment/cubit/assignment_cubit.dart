import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/assignment/cubit/assignment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  static final bookingRepository = getIt<BookingRepository>();

  AssignmentCubit() : super(AssignmentInitial());

  Future<void> loadAssignments() async {
    emit(AssignmentLoading());

    final result = await bookingRepository.getAssignments();

    result.fold(
      (failure) => emit(AssignmentError(failure.message)),
      (assignments) => emit(AssignmentLoaded(assignments)),
    );
  }
}