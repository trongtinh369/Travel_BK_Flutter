import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_guide/cubit/schedule_tourguide_sate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleTourguideCubit extends Cubit<ScheduleTourguideState> {
  final BookingRepository bookingRepository;
  final AuthCubit authCubit;

  // lấy AuthCubit từ constructor
  ScheduleTourguideCubit({
    required this.authCubit,
    required this.bookingRepository,
  }) : super(ScheduleTourguideInitial());

  Future<void> loadSchedules() async {
    print('📋 Starting loadSchedules');
    emit(ScheduleTourguideLoading());

    final user = authCubit.state;
    final staffId = user.id;
    

    if (staffId == null || staffId == 0) {
  
      emit(ScheduleTourguideError("Không tìm thấy thông tin đăng nhập"));
      return;
    }



    final result = await bookingRepository.getSchedulesByStaff(staffId: staffId);

    result.fold(
      (failure) {
  
        emit(ScheduleTourguideError(failure.message));
      },
      (schedules) {
   
        emit(ScheduleTourguideLoaded(schedules));
      },
    );
  }
}