import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/request/create_user_request.dart';
import 'package:booking_tour_flutter/data/request/verify_otp_request.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp/cubit/auth_otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthOtpCubit extends Cubit<AuthOtpState> {
  static final authRepository = getIt<BookingRepository>();

  AuthOtpCubit() : super(AuthOtpState(user: CreateUserRequest.empty(), verifyOtp: false, checkCreate: false));

  void setUser(CreateUserRequest user) {
    emit(state.copyWith(user: user));
  }

  Future<void> verifyOTP(String code) async {
    await DialogHelper.showLoadingDialog();

    var resualt = await authRepository.verifyOTP(
      VerifyOtpRequest(email: state.user.email, code: code),
    );

    var context = AppNavigator.currentContext;

    resualt.fold(
      (left) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mã OTP sai hoặc đã hết hiệu lực')),
        );
      },
      (verifyOtp) {
        emit(state.copyWith(verifyOtp: verifyOtp));
      },
    );

    DialogHelper.dismissDialog();
  }

  Future<void> sendOTP() async {
    var resualt = await authRepository.sendOTP(state.user.email);

    var context = AppNavigator.currentContext;

    resualt.fold(
      (left) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email này không gửi tin nhắn vào được')),
        );
      },
      (check) {
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gửi mã thành công')),
        );
      },
    );
  }

  Future<void> createUser() async {
    var resualt = await authRepository.registerUser(createUser: state.user);

    resualt.fold((left){

    }, (right){
      emit(state.copyWith(checkCreate: true));
    });
  }
}
