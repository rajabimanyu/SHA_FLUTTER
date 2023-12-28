import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/data/network/repository/surroundings_repository.dart';
import 'package:sha/models/surrounding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/repository/environments_repository.dart';
import '../../models/environment.dart';

class HomeCubit extends Cubit<UIState> {
  final EnvironmentsRepository _environmentsRespository;
  final SurroundingsRepository _surroundingsRepository;

  HomeCubit(
      this._environmentsRespository,
      this._surroundingsRepository
  ): super(InitialState());

  void fetchHomeData() async {
    emit(LoadingState());
    final List<String> environments = await _fetchEnvironments();
    final currentHome = _getCurrentEnvironmentDB();
    if(environments.isNotEmpty) {
      if (currentHome == null) {
        await _storeCurrentHomeDB(environments);
        emit(SuccessState(await _fetchSurroundings(environments[0])));
      } else {
        final String environment = environments.firstWhere((element) => element == currentHome.uuid, orElse: () => "");
        if(environment == currentHome.uuid) {
          emit(SuccessState(await _fetchSurroundings(environment)));
        } else {
          emit(FailureState(DataError(message: "No Environments Found", dataErrorType: DataErrorType.ENV_NOT_AVAILABLE)));
        }
      }
    } else {
      emit(FailureState(DataError(message: "No Environments Found", dataErrorType: DataErrorType.ENV_NOT_AVAILABLE)));
    }
  }

  Future<List<Surrounding>> _fetchSurroundings(String environmentId) async {
    final surroundingsResponse = await _surroundingsRepository.fetchSurroundings(environmentId);
    if(surroundingsResponse.success) {
      if(surroundingsResponse.data != null) {
        final surroundingsList = surroundingsResponse.data!;
        return surroundingsList;
      } else {
        List.empty();
      }
    }
    return List.empty();
  }

  Future<List<String>> _fetchEnvironments() async {
    final environmentsResponse = await _environmentsRespository.fetchEnvironments();
    if(environmentsResponse.success) {
      if(environmentsResponse.data != null) {
        final environmentList = environmentsResponse.data!;
        log('home cubit fetch env : $environmentList');
        return environmentList;
      } else {
        log('home cubit fetch env : data null');
        List.empty();
      }
    }
    log('home cubit fetch env : failure');
    return List.empty();
  }

  Environment? _getCurrentEnvironmentDB() {
    return Environment(uuid: "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430", name: "Raj Home", isCurrentEnvironment: true);
  }

  Future<bool> _storeCurrentHomeDB(List<String> environments) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return true;
    //store first element in DB
  }
}