import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/data/network/repository/auth_repository.dart';
import 'package:sha/data/network/repository/environments_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<UIState> {
  final AuthRepository _authRepository;
  final EnvironmentsRepository _environmentsRespository;

  LoginCubit(this._authRepository, this._environmentsRespository) : super(InitialState());

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
      emit(FailureState(UserError(message: 'Unable to login user', data: LoginErrorType.LOGIN_FAILED)));
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
      print(data);
      final bool isSaved = await storeSession(data.sessionId);
      if(data.sessionId.isNotEmpty && isSaved) {
        emit(SuccessState(data));
      } else {
        emit(FailureState(UiError(message: 'Error in storing session')));
      }
    } else {
      emit(FailureState(UiError(message: result.error?.message ?? 'Error')));
    }
  }

  Future<bool> storeSession(String sessionKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('session_id', sessionKey);
  }
}
