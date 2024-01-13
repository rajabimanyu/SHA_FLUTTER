import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/data/network/repository/auth_repository.dart';
import 'package:sha/data/network/repository/environments_repository.dart';
import 'package:sha/models/user.dart';
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
      // IdTokenResult idTokenResult = await user.getIdTokenResult(true);
      // String? id = idTokenResult.token;
      // log("logged in $token : $id");
      loginUser(userName: userName, email: email, token: token,id: "id");
    }
  }

  Future<bool> storeSession(String? sessionKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(sessionKey != null) {
      return await prefs.setString('session_id', sessionKey);
    } else {
      return Future.value(false);
    }
  }

  void loginUser({
    required String userName,
    required String email,
    required String token,
    required String? id
  }) async {
    final bool isSaved = await storeSession(id);
    if (isSaved) {
      emit(SuccessState(
          UserObject(sessionId: token, name: userName, email: email)));
    } else {
      emit(FailureState(UiError(message: 'Error in storing session')));
    }
  }
}
