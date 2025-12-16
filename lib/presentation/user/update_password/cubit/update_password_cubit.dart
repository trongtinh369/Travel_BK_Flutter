import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/update_password_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  final BookingRepository repository;
  UpdatePasswordCubit(this.repository) : super(UpdatePasswordInitial());

  Future<void> updatePassword(int userId, UpdatePasswordUser data) async {
    emit(UpdatePasswordLoading());
    final result = await repository.updatePasswordUserById(
      userId: userId,
      oldPassword: data.oldPassword,
      newPassword: data.newPassword,
    );

    result.fold(
      (failure) => emit(UpdatePasswordError(failure.message)),
      (_) => emit(UpdatePasswordSuccess()),
    );
  }
}
