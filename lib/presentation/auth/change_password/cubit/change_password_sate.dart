class ChangePasswordSate {
  final bool changeDone;
  final String email;
  ChangePasswordSate({
    required this.changeDone,
    required this.email,
  });
  
  ChangePasswordSate copyWith({bool? changeDone, String? email}){
    return ChangePasswordSate(changeDone: changeDone ?? this.changeDone, email: email ?? this.email);
  }
}
