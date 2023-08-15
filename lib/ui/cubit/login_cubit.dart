import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/data/network/repository/auth_repository.dart';

class LoginCubit extends Cubit<UIState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(InitialState());

  void signInWithGoogle() async {
    emit(LoadingState());
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['email']).signIn();
    if (googleUser == null) {
      emit(FailureState(UiError(message: 'Sign in with Google cancelled')));
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) {
      emit(FailureState(UiError(message: 'Unable to login user')));
    } else {
      final userName = user.displayName ?? '';
      final email = user.email ?? '';
      final token = user.uid;
      loginUser(userName: userName, email: email, token: token);
    }
  }

  void loginUser({
    required String userName,
    required String email,
    required String token,
  }) async {
    final result = await _authRepository.loginUser();
    if (result.success && result.data != null) {
      final data = result.data!;
      emit(SuccessState(data));
    } else {
      emit(FailureState(UiError(message: result.error?.message ?? 'Error')));
    }
  }
}
