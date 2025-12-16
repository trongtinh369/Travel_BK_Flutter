import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/pay_booking.dart';
import 'package:booking_tour_flutter/domain/schedule_book.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/presentation/user/pay/cubit/pay_schedule_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayScheduleCubit extends Cubit<PayScheduleState> {
  static final payScheduleRepository = getIt<BookingRepository>();

  PayScheduleCubit()
    : super(
        PayScheduleState(
          paySchedule: Booking.empty(),
          schedule: ScheduleTourmanager.empty(),
          linkQR:
              "https://img.vietqr.io/image/VCB-1039744434-compact2.png?amount=0&addInfo=thanh%20toan%20chuyen%20di&accountName=Thanh%20Toan%20Chuyen%20Di",
          idBooking: 0,
          idSchedule: 0,
        ),
      );

  Future<void> loadData() async {
    var result = await payScheduleRepository.getScheduleBookById(
      state.idSchedule,
    );

    result.fold((failure) {}, (schedule) {
      emit(state.copyWith(schedule: schedule));
    });

    var paySchedule = await payScheduleRepository.getBookingById(
      id: state.idBooking,
    );

    paySchedule.fold((failure) {}, (paySchedule) {
      emit(
        state.copyWith(
          paySchedule: paySchedule,
          linkQR:
              "https://img.vietqr.io/image/VCB-1039744434-compact2.png?amount=${paySchedule.totalPrice}&addInfo=thanh%20toan%20chuyen%20di%20ma%20${paySchedule.code}%20&accountName=Thanh%20Toan%20Chuyen%20Di",
        ),
      );
    });
  }

  void setId({int? idSchedule, int? idBooking}) {
    emit(state.copyWith(idSchedule: idSchedule, idBooking: idBooking));
  }
}
