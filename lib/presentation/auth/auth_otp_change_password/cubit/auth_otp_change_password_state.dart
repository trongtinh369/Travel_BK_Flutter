

class AuthOtpChangePasswordState {
  final bool verifyOtp;
  final String email;
  AuthOtpChangePasswordState({
    required this.verifyOtp,
    required this.email
  });
  AuthOtpChangePasswordState copyWith({bool? verifyOtp, String? email}){
    return AuthOtpChangePasswordState(verifyOtp: verifyOtp ?? this.verifyOtp, email: email ?? this.email);
  }
}
