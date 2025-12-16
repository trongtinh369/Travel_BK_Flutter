class RegisterState {
  bool isEmailExist;
  bool checkSendOtp;

  RegisterState({required this.isEmailExist, required this.checkSendOtp});

  RegisterState copyWith({
    bool? isEmailExist,
    bool? checkSendOtp,
  }) {
    return RegisterState(
      checkSendOtp: checkSendOtp ?? this.checkSendOtp,
      isEmailExist: isEmailExist ?? this.isEmailExist,
    );
  }
}
