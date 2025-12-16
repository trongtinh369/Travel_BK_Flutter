import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/network/dio/failure.dart';
import 'package:booking_tour_flutter/data/request/change_password_request.dart';
import 'package:booking_tour_flutter/presentation/auth/change_password/cubit/change_password_sate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordSate> {
  static final changeRepository = getIt<BookingRepository>();

  ChangePasswordCubit() : super(ChangePasswordSate(changeDone: false, email: ""));

  void setEmail(String email){
    emit(state.copyWith(email: email));
  }

  Future<void> changePassword(String newPassword) async {
    var result = await changeRepository.changePassword(ChangePasswordRequest(email: state.email, newPassword: newPassword));

    result.fold((failure){

    }, (isSuccess){
      emit(state.copyWith(changeDone: isSuccess));
    });
  }
}