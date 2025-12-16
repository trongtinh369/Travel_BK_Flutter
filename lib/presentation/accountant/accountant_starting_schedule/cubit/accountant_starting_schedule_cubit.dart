import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_starting_schedule/cubit/accountant_starting_schedule_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountantStartingScheduleCubit
    extends Cubit<AccountantStartingScheduleState> {
  final _repository = getIt<BookingRepository>();

  AccountantStartingScheduleCubit() : super(AccountantStartingScheduleInit());

  Future<void> getData() async {
    emit(AccountantStartingScheduleLoading());
    var result = await _repository.getScheduleForAccountant();

    result.fold(
      (failure) {
        emit(
          AccountantStartingScheduleError(
            errorMessage: "Lỗi xảy ra trong quá trình lấy dữ liệu",
          ),
        );
      },
      (schedules) {
        emit(AccountantStartingScheduleLoaded(schedules: schedules));
      },
    );
  }
}
