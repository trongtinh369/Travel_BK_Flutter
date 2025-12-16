import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';


class ProfileCubit extends Cubit<ProfileState> {
  final BookingRepository bookingRepository;
  ProfileCubit(this.bookingRepository) : super(ProfileInitial());

  Future<void> loadUser(int userId) async {
    emit(ProfileLoading());
    final result = await bookingRepository.getUserById(id: userId);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(ProfileLoaded(user)),
    );
  }
}