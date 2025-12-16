import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/request/check_account_request.dart';
import 'package:booking_tour_flutter/presentation/auth/forget_password/cubit/forget_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetCubit extends Cubit<ForgetState> {
  static final forgetRepository = getIt<BookingRepository>();

  ForgetCubit()
    : super(ForgetState(existedEmail: false, email: ""));

  Future<void> checkEmail(String email) async {
    await DialogHelper.showLoadingDialog();

    var result = await forgetRepository.checkEmailAccount(
      checkEmailAccount: CheckAccountRequest(email: email),
    );
    result.fold((left) {}, (right) {
      emit(state.copyWith(email: email, existedEmail: right));
    });
    DialogHelper.dismissDialog();
  }

  Future<void> sendOTP() async {
    var resualt = await forgetRepository.sendOTP(state.email);

    var context = AppNavigator.currentContext;

    resualt.fold((left) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email này không gửi tin nhắn vào được')),
      );
    }, (check) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã gửi được tin nhắn')),
      );
    });
  }
}
