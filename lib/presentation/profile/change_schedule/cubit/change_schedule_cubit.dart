import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/presentation/profile/change_schedule/cubit/change_schedule_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeScheduleCubit extends Cubit<ChangeScheduleState> {
  final BookingRepository _repository = getIt<BookingRepository>();
  ChangeScheduleCubit()
    : super(ChangeScheduleLoadSuccess(schedules: [], bookingId: 0));

  Future<void> loadData(Booking booking) async {
    var result = await _repository.getSchedulesByTourId(
      booking.schedule.tourId,
    );

    ChangeScheduleLoadSuccess? newState;
    if (state is ChangeScheduleLoadSuccess) {
      newState = state as ChangeScheduleLoadSuccess;
    } else {
      newState = ChangeScheduleLoadSuccess(schedules: [], bookingId: 0);
    }

    result.fold(
      (failure) {
        emit(
          ChangeScheduleLoadFail(
            message: "Xảy ra lỗi trong quá trình tải dữ liệu",
          ),
        );
      },
      (schedules) {
        emit(
          newState!.copyWith(
            schedules:
                schedules
                    .where((schedule) => schedule.id != booking.schedule.id)
                    .toList(),
            bookingId: booking.id,
          ),
        );
      },
    );
  }

  Future<void> changeBooking(int scheduleId) async {
    await DialogHelper.showLoadingDialog();
    if (state is! ChangeScheduleLoadSuccess) {
      DialogHelper.dismissDialog();
      return;
    }

    var nowState = state as ChangeScheduleLoadSuccess;

    var result = await _repository.changeBookingTour(
      bookingId: nowState.bookingId,
      scheduleId: scheduleId,
    );

    result.fold(
      (failure) => emit(ChangeScheduleLoadFail(message: failure.message)),
      (booking) {
        emit(ChangedSchedule(booking: booking));
      },
    );
    DialogHelper.dismissDialog();


    return;
  }
}
