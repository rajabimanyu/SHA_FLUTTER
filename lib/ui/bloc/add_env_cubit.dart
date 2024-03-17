import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/data/repository/data_response.dart';
import 'package:sha/models/environment.dart';

import '../../data/repository/environments_repository.dart';
import '../../data/repository/surroundings_repository.dart';

class AddNewEnvironmentBloc extends Cubit<UIState> {
  final HomeRepository _environmentsRespository;
  final SurroundingsRepository _surroundingsRepository;
  AddNewEnvironmentBloc(this._environmentsRespository, this._surroundingsRepository): super(InitialState());
  
  void createEnvironmentAndSurrounding(String environmentName, String surroundingName) async {
    emit(LoadingState());
    final DataResponse environmentResponse = await _environmentsRespository.createEnvironment(environmentName);
    if(environmentResponse.success) {
      final Environment environment = environmentResponse.data;
      final DataResponse surroundingsResponse = await _surroundingsRepository.createSurrounding(surroundingName, environment.uuid);
      if(surroundingsResponse.success) {
        emit(SuccessState(true));
      } else {
        emit(FailureState(DataError(message: 'Failed in creating Surrounding',dataErrorType: DataErrorType.CREATE_SURROUNDING_ERROR)));
      }
    } else {
      emit(FailureState(DataError(message: 'Failed in creating Environment',dataErrorType: DataErrorType.CREATE_ENVIRONMENT_ERROR)));
    }
  }
}