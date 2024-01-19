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
  final EnvironmentsRepository _environmentsRespository;
  final SurroundingsRepository _surroundingsRepository;

  HomeCubit(
      this._environmentsRespository,
      this._surroundingsRepository
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

  void fetchDeviceData(String surroundingId) async {
    emit(LoadingState());
    final List<Device> devices = await _environmentsRespository.fetchDevices(surroundingId);
    if(devices.isNotEmpty) {
      emit(SuccessState(devices));
    } else {
      emit(FailureState(DataError(message: "No Devices Found", dataErrorType: DataErrorType.DEVICES_NOT_AVAILABLE)));
    }
  }
}