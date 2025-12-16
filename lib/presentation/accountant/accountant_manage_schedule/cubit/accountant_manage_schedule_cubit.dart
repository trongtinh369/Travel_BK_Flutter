import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/request/booking/update_status_booking_request.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/booking_status.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_manage_schedule/cubit/accountant_manage_schedule_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountantManageScheduleCubit
    extends Cubit<AccountantManageScheduleState> {
  static final bookingRepository = getIt<BookingRepository>();
  AccountantManageScheduleCubit()
    : super(
        AccountantManageScheduleState(
          status: BookingStatus.copyWith(id: 1),
          scheduleTourmanager: ScheduleTourmanager.empty(),
          bookingProcessing: [Booking.empty()],
          bookingDeposit: [Booking.empty()],
          bookingPay: [Booking.empty()],
        ),
      );

  Future<void> loadData() async {
    var bookings = await bookingRepository.getBookingsByScheduleId(
      state.scheduleTourmanager.id,
    );

    bookings.fold((failure) {}, (bookings) {
      var bookingProcessing =
          bookings
              .where((e) => e.status.id == BookingStatus.processingId)
              .toList();
      var bookingDeposit =
          bookings
              .where((e) => e.status.id == BookingStatus.depositId)
              .toList();
      var bookingPay =
          bookings.where((e) => e.status.id == BookingStatus.payId).toList();

      emit(
        state.copyWith(
          bookingProcessing: bookingProcessing,
          bookingDeposit: bookingDeposit,
          bookingPay: bookingPay,
        ),
      );
    });
  }

  Future<void> updateStatusBooking({
    required int id,
    required int statusId,
  }) async {
    var updateStatusBooking = UpdateStatusBookingRequest(
      id: id,
      statusId: statusId,
    );

    var result = await bookingRepository.updateStatusBooking(
      updateStatusBooking,
    );

    result.fold((failure) {}, (right) {
      var oldBooking = state.bookingProcessing.firstWhere((b) => b.id == id);

      var updatedBooking = oldBooking.copyWith(
        status: BookingStatus.copyWith(id: statusId),
      );

      final updatedProcessing =
          state.bookingProcessing.where((b) => b.id != id).toList();

      List<Booking> updatedDeposit = state.bookingDeposit;
      List<Booking> updatedPay = state.bookingPay;

      if (statusId == BookingStatus.depositId) {
        updatedDeposit = List.from(state.bookingDeposit)..add(updatedBooking);
      } else if (statusId == BookingStatus.payId) {
        updatedPay = List.from(state.bookingPay)..add(updatedBooking);
      }

      emit(
        state.copyWith(
          bookingProcessing: updatedProcessing,
          bookingDeposit: updatedDeposit,
          bookingPay: updatedPay,
        ),
      );
    });
  }

  Future<void> deleteBooking({required int bookingId}) async {
    var result = await bookingRepository.deleteBooking(bookingId);

    result.fold((failure) {}, (right) {
      final updatedList =
          state.bookingProcessing
              .where((booking) => booking.id != bookingId)
              .toList();

      emit(state.copyWith(bookingProcessing: updatedList));
    });
  }

  void setBooking(ScheduleTourmanager schedule) {
    emit(state.copyWith(scheduleTourmanager: schedule));
  }

  List<Booking> getBookingProcessing() {
    return state.bookingProcessing;
  }

  List<Booking> getBookingDeposit() {
    return state.bookingDeposit;
  }

  List<Booking> getBookingPay() {
    return state.bookingPay;
  }

  void setStatus({required BookingStatus status}) {
    emit(state.copyWith(status: status));
  }

  BookingStatus getStatus() {
    return state.status;
  }
}
