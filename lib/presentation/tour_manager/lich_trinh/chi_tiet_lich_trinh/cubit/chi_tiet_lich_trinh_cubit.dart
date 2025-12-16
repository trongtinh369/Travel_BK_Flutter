import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/requests/update_schedule_request.dart';

class ChiTietLichTrinhCubit {
  final BookingRepository _repo = getIt<BookingRepository>();

  Future<bool> updateSchedule(UpdateScheduleRequest request) async {
    final result = await _repo.updateSchedule(request);
    return result.fold((failure) => false, (success) => success);
  }
}
