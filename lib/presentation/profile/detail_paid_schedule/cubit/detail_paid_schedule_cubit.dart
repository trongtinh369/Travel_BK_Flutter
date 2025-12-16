import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/response/booking_response.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/presentation/profile/change_schedule/cubit/change_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/profile/detail_paid_schedule/cubit/detail_paid_schedule_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPaidScheduleCubit extends Cubit<DetailPaidScheduleState> {
  final BookingRepository _repository = getIt<BookingRepository>();

  DetailPaidScheduleCubit()
    : super(DetailPaidScheduleState(booking: Booking.empty()));

  void setBooking(Booking booking) {
    emit(state.copyWith(booking: booking));
  }

  Future<void> loadFakeData() async {
    var result = await _repository.getBookingByUserId(userId: 6);

    result.fold((failure) {}, (bookings) {
      setBooking(bookings[0]);
    });
  }

  void changeSchedule() {
    if (state.booking.schedule.startDate.isBefore(
      DateTime.now().subtract(Duration(days: 3)),
    )) {
      emit(state.copyWith(errorMessage: "Đã quá hạn để đổi chuyến đi"));
      return;
    }

    if (state.booking.countChangeLeft == 0) {
      emit(state.copyWith(errorMessage: "Bạn đã đổi quá số lần cho phép"));
      return;
    }

    AppNavigator.currentContext.read<ChangeScheduleCubit>().loadData(
      state.booking,
    );
    Navigator.pushNamed(
      AppNavigator.currentContext,
      RouteName.profileChangeSchedule,
    );
  }

  Future<void> deleteBooking() async {
    var result = await _repository.deleteBooking(state.booking.id);

    result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
      },
      (booking) {
        emit(
          state.copyWith(
            message:
                "Hủy chuyến đi thành công, Số tiền còn thừa sẽ được cộng vào ví của bạn (Tổng số tiền đã trả - số tiền cọc của chuyến đi)",
          ),
        );
      },
    );
  }
}
