
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/data/repository/data_response.dart';
import 'package:sha/data/repository/models/create_device_response.dart';
import 'package:sha/models/environment.dart';
import 'package:sha/models/surrounding.dart';

import '../../data/repository/device_repository.dart';
import '../../data/repository/home_repository.dart';
import '../../data/repository/surroundings_repository.dart';

class AddNewEnvironmentBloc extends Cubit<UIState> {
  final HomeRepository _environmentsRespository;
  final SurroundingsRepository _surroundingsRepository;
  final DeviceRepository _deviceRepository;
  AddNewEnvironmentBloc(this._environmentsRespository, this._surroundingsRepository, this._deviceRepository): super(InitialState());
  
  void createEnvironmentAndSurrounding(String deviceId, String environmentName, String surroundingName) async {
    try {
      emit(LoadingState());
      final DataResponse environmentResponse = await _environmentsRespository.createEnvironment(environmentName);
      if(environmentResponse.success) {
        final Environment environment = environmentResponse.data;
        final DataResponse surroundingsResponse = await _surroundingsRepository.createSurrounding(surroundingName, environment.uuid);
        if(surroundingsResponse.success) {
          final Surrounding surrounding = surroundingsResponse.data;
          final DataResponse<CreateDeviceResponse, DataError> createDeviceResponse = await _deviceRepository.createDevice(deviceId, environment.uuid, surrounding.uuid);
          if(createDeviceResponse.success) {
            final createDevice = createDeviceResponse.data;
            if(createDevice?.isDeviceCreated ?? false) {
              final status = createDevice?.status;
              emit(SuccessState(status));
            }
          } else if(createDeviceResponse.error != null) {
            emit(FailureState(
                DataError(message: createDeviceResponse.error?.message ?? '' ,dataErrorType: createDeviceResponse.error?.dataErrorType ?? DataErrorType.CREATE_DEVICE_ERROR)
            ));
          }
          emit(FailureState(DataError(message: 'Failed in creating Device',dataErrorType: DataErrorType.CREATE_DEVICE_ERROR)));
        } else {
          emit(FailureState(DataError(message: 'Failed in creating Surrounding',dataErrorType: DataErrorType.CREATE_SURROUNDING_ERROR)));
        }
      } else {
        emit(FailureState(DataError(message: 'Failed in creating Environment',dataErrorType: DataErrorType.CREATE_ENVIRONMENT_ERROR)));
      }
    }catch(error, stack) {
      log('error in creating environment: $error');
      log('error in creating environment: $stack');
      emit(FailureState(DataError(message: error.toString(),dataErrorType: DataErrorType.CREATE_ENVIRONMENT_ERROR)));
    }
  }
}