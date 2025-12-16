import 'package:booking_tour_flutter/data/request/create_user_request.dart';

class AuthOtpState {
  final CreateUserRequest user;
  final bool verifyOtp;
  final bool checkCreate;

  AuthOtpState({required this.user, required this.verifyOtp, required this.checkCreate});

  AuthOtpState copyWith({bool? verifyOtp, CreateUserRequest? user, bool? checkCreate}){
    return AuthOtpState(user: user ?? this.user, verifyOtp: verifyOtp ?? this.verifyOtp, checkCreate: checkCreate ?? this.checkCreate);
  }
}