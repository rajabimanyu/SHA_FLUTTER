import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/data/repository/surroundings_repository.dart';
import 'package:sha/models/device.dart';
import 'package:sha/models/surrounding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository/environments_repository.dart';
import '../../models/environment.dart';

class HomeCubit extends Cubit<UIState> {
  final HomeRepository _environmentsRespository;

  HomeCubit(
      this._environmentsRespository
  ): super(InitialState());

  void fetchHomeData() async {
    log("fetchhomedata");
    emit(LoadingState());
    final List<Surrounding> surroundings = await _environmentsRespository.fetchHomeSurroundings();
    if(surroundings.isNotEmpty) {
      emit(SuccessState(surroundings));
    } else {
      emit(FailureState(DataError(message: "No Data Found", dataErrorType: DataErrorType.ENV_NOT_AVAILABLE)));
    }
  }
}