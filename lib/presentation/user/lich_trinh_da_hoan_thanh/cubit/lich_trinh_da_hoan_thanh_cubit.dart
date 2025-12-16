import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/presentation/user/lich_trinh_da_hoan_thanh/cubit/lich_trinh_da_hoan_thanh_state.dart';
import 'package:booking_tour_flutter/presentation/user/lich_trinh_da_hoan_thanh/lich_trinh_da_hoan_thanh_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LichTrinhDaHoanThanhCubit extends Cubit<LichTrinhDaHoanThanhState> {
  final bookingRepository = getIt<BookingRepository>();
  LichTrinhDaHoanThanhCubit() : super(LichTrinhDaHoanThanhState(tour: [], schedule: []));

  Future<void> syncSchedule(int id) async{
    var result1 = await bookingRepository.getScheduleUserCompletedByUserId(userId: id);
    var result2 = await bookingRepository.getTrips();

    result1.fold((failure){}, (schedule){
      emit(state.copyWith(schedule: schedule));
    });

    result2.fold((failure){}, (tour){
      emit(state.copyWith(tour: tour));
    });
  }
}