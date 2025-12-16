class ForgetState {
  final bool existedEmail;
  final String email;
  ForgetState({
    required this.existedEmail,
    required this.email
  });

  ForgetState copyWith({bool? existedEmail, String? email}){
    return ForgetState(existedEmail: existedEmail ?? this.existedEmail, email: email ?? this.email);
  }
}
