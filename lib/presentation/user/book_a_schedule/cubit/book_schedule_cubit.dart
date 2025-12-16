import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/request/booking/booking_schedule_request.dart';
import 'package:booking_tour_flutter/domain/schedule_book.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/presentation/user/book_a_schedule/cubit/book_schedule_state.dart';
import 'package:booking_tour_flutter/presentation/widgets/payment_option.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookScheduleCubit extends Cubit<BookScheduleState> {
  static final bookScheduleRepository = getIt<BookingRepository>();

  BookScheduleCubit()
    : super(
        BookScheduleState(
          schedule: ScheduleTourmanager.empty(),
          idSchedule: 0,
          idBooking: 0,
          hinhThuc: HinhThuc.thanhtoantoanbo,
          tienThanhToanHet: 0,
          tienThanhToanCoc: 0,
          isBooking: false,
          totalPrice: 0,
        ),
      );

  Future<void> loadData() async {
    var result = await bookScheduleRepository.getScheduleBookById(state.idSchedule);

    result.fold((failure) {}, (schedule) {
      emit(
        state.copyWith(
          schedule: schedule,
          tienThanhToanHet: schedule.finalPrice,
          tienThanhToanCoc:
              (schedule.finalPrice * schedule.desposit / 100)
                  .toInt(),
          totalPrice: schedule.finalPrice,
        ),
      );
    });
  }

  void rebuild(){ 
    emit(state.copyWith());
  }

  void setIdSchedule(int idSchedule){
    emit(state.copyWith(idSchedule: idSchedule));
  }

  void setHinhThuc({required HinhThuc hinhThuc}) {
    emit(
      state.copyWith(
        hinhThuc: hinhThuc,
        totalPrice:
            hinhThuc == HinhThuc.thanhtoantoanbo
                ? state.tienThanhToanHet
                : state.tienThanhToanCoc,
      ),
    );
  }

  int totalPrice() {
    return state.totalPrice;
  }

  void setIsBooking(){
    emit(state.copyWith(isBooking: false));
  }

  Future<void> booking({
    required int userId,
    required int numPeople,
    required String email,
    required String phone,
  }) async {
    await DialogHelper.showLoadingDialog();

    var result = await bookScheduleRepository.createBooking(
      booking: BookingScheduleRequest(
        scheduleId: state.idSchedule,
        userId: userId,
        numPeople: numPeople,
        email: email,
        phone: phone,
        totalPrice: state.totalPrice * numPeople,
      ),
    );

    result.fold((failure) async {
      DialogHelper.dismissDialog();
      await DialogHelper.showInformDialog(Text(failure.message));
    }, (result) {
      emit(state.copyWith(isBooking: true, idBooking: result));
      DialogHelper.dismissDialog();
    });

  }
}
