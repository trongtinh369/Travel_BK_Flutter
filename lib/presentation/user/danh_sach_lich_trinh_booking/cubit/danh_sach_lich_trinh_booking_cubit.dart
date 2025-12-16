import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_lich_trinh_booking/cubit/danh_sach_lich_trinh_booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanhSachLichTrinhBookingCubit extends Cubit<DanhSachLichTrinhBookingState> {
  final bookingRepository = getIt<BookingRepository>();

  DanhSachLichTrinhBookingCubit() : super(DanhSachLichTrinhBookingState(booking: []));

  Future<void> syncBooking(int id) async{
    var result = await bookingRepository.getBookingByUserId(userId: id);

    result.fold((fail){},
      (bookings){
        emit(state.copyWith(booking: bookings));
      }
    );
  }
}