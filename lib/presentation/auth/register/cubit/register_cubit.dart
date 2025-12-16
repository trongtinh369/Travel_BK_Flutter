import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/request/check_account_request.dart';
import 'package:booking_tour_flutter/presentation/auth/register/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  static final registerRepository = getIt<BookingRepository>();

  RegisterCubit()
    : super(RegisterState(isEmailExist: false, checkSendOtp: false));

  Future<void> checkEmailAccount(String email) async {
    await DialogHelper.showLoadingDialog();

    var resualt = await registerRepository.checkEmailAccount(
      checkEmailAccount: CheckAccountRequest(email: email),
    );

    resualt.fold((left) {}, (checkes) {
      emit(state.copyWith(isEmailExist: checkes));
    });

    DialogHelper.dismissDialog();
  }

  Future<void> sendOTP(String email) async {
    var resualt = await registerRepository.sendOTP(email);

    var context = AppNavigator.currentContext;

    resualt.fold(
      (left) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email này không gửi tin nhắn vào được'),
          ),
        );
      },
      (check) {
        emit(state.copyWith(checkSendOtp: check));
      },
    );
  }
}
