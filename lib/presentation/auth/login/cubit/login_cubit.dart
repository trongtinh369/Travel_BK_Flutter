import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/user.dart';
import 'package:booking_tour_flutter/presentation/auth/login/cubit/login_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginCubit extends Cubit<LoginState> {
  static final userRepository = getIt<BookingRepository>();
  final GoogleSignIn googleSignIn;
  final messaging = FirebaseMessaging.instance;

  LoginCubit({GoogleSignIn? googleSignIn}) 
      : googleSignIn = googleSignIn ?? GoogleSignIn(),
        super(LoginState(user: User.empty()));
  
  Future<void> login(String email, String password) async {
    await DialogHelper.showLoadingDialog();

    String? token = await messaging.getToken() ?? "";

    var result = await userRepository.postLogin(email: email, password: password, token: token);

    result.fold((failure) {
      emit(state.copyWithError());
    }, (user){
      emit(state.copyWith(user: user));
    });

    DialogHelper.dismissDialog();
  }

  Future<void> loginWithGoogle() async {

    try {
      await googleSignIn.signOut();

      // Đăng nhập Google
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      
      if (googleUser == null) {
        DialogHelper.dismissDialog();
        return;
      }

      await DialogHelper.showLoadingDialog();

      //Lấy thông tin user từ Google
      final String email = googleUser.email;
      final String name = googleUser.displayName ?? '';
      final String photoUrl = googleUser.photoUrl ?? '';
      String? token = await messaging.getToken() ?? "";

      
      var result = await userRepository.loginByEmail(
        email: email,
        name: name,
        photoUrl: photoUrl,
        token: token
      );

      result.fold((failure) {
        emit(state.copyWithError());
      }, (user){
        emit(state.copyWith(user: user));
      });

      DialogHelper.dismissDialog();

    } catch (error) {
      DialogHelper.dismissDialog();
      print("lỗi $error");
      emit(state.copyWithError());
    }

  }

  Future<void> loginWithFacebook() async {
    try {
      
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status != LoginStatus.success) {
        return;
      }

      await DialogHelper.showLoadingDialog();

      
      final userData = await FacebookAuth.instance.getUserData(
        fields: "name,email,picture.width(200)",
      );

      final String email = userData['email'] ?? '';
      final String name = userData['name'] ?? '';
      final String photoUrl = userData['picture']?['data']?['url'] ?? '';
      String? token = await messaging.getToken() ?? "";
      
      
      var response = await userRepository.loginByEmail(
        email: email,
        name: name,
        photoUrl: photoUrl,
        token: token
      );

      response.fold((failure) {
        emit(state.copyWithError());
      }, (user){
        emit(state.copyWith(user: user));
      });

      DialogHelper.dismissDialog();

    } catch (error) {
      DialogHelper.dismissDialog();
      print("lỗi $error");
      emit(state.copyWithError());
    }
  }
}