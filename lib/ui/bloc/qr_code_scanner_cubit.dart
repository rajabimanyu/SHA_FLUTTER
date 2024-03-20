import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/models/environment.dart';
import '../../data/repository/environments_repository.dart';

class QrCodeScannerCubit extends Cubit<UIState> {
  final HomeRepository _environmentRepository;
  QrCodeScannerCubit(this._environmentRepository): super(InitialState());

  void fetchEnvironments() async {
    try {
      emit(LoadingState());
      final List<Environment> environments = await _environmentRepository.fetchEnvironments();
      if(environments.isNotEmpty) {
        emit(SuccessState(true));
      } else {
        emit(SuccessState(false));
      }
    } catch (err, stack) {
      log('error in fetching environment: $err');
      log('error in fetching environment: $stack');
      emit(FailureState(DataError(message: err.toString(),dataErrorType: DataErrorType.FETCH_ENVIRONMENT_ERROR)));
    }
  }
}