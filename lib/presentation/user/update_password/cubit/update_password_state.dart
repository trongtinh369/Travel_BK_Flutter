abstract class UpdatePasswordState {}

class UpdatePasswordInitial extends UpdatePasswordState {}

class UpdatePasswordLoading extends UpdatePasswordState {}

class UpdatePasswordSuccess extends UpdatePasswordState {}

class UpdatePasswordError extends UpdatePasswordState {
  final String message;
  UpdatePasswordError(this.message);
}
