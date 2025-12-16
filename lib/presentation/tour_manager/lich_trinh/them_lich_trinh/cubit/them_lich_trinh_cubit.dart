import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/domain/requests/add_schedule_request.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'them_lich_trinh_state.dart';

class ThemLichTrinhCubit extends Cubit<ThemLichTrinhState> {
  final _repository = getIt.get<BookingRepository>();

  ThemLichTrinhCubit() : super(ThemLichTrinhState());

  Future<void> createSchedule(AddScheduleRequest request) async {
    await _repository.addSchedule(request);
  }
}
