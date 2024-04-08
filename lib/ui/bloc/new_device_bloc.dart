import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sha/base/ShaConstants.dart';
import 'package:sha/data/repository/environments_repository.dart';
import 'package:sha/data/repository/surroundings_repository.dart';
import 'package:sha/models/environment.dart';
import 'package:sha/models/surrounding.dart';
import 'package:sha/ui/bloc/events/create_device_events.dart';
import 'package:sha/ui/bloc/states/create_device_state.dart' as createDeviceStates;
import 'package:sha/util/ShaUtils.dart';

import '../../core/model/ui_state.dart' as uiStates;
import '../../data/repository/data_response.dart';
import '../../data/repository/device_repository.dart';
import '../../data/repository/models/create_device_response.dart';

class NewDeviceBloc extends Bloc<CreateEvent, createDeviceStates.CreateState> {
  final SurroundingsRepository _surroundingsRepository;
  final DeviceRepository _deviceRepository;
  final HomeRepository _homeRepository;
  NewDeviceBloc(
      this._surroundingsRepository,
      this._deviceRepository,
      this._homeRepository
      ): super(const createDeviceStates.InitialState()) {
    on<InitNewDeviceEvent>(_fetchSurroundings);
    on<CreateDeviceEvent>(_createDevice);
    on<CreateSurroundingWithDeviceEvent>(_createSurroundingAndDevice);
  }

  Future<void> _fetchSurroundings(InitNewDeviceEvent event, Emitter<createDeviceStates.CreateState> emit) async {
    try {
      final Environment currentEnvironment = await _homeRepository.getCurrentEnvironment(Environment(uuid: '', name: '', isCurrentEnvironment: false));
      log('currenbt env fou $currentEnvironment');
      final List<Surrounding> surroundings =await _surroundingsRepository.fetchSurroundings(currentEnvironment.uuid);
      log('surr foun $surroundings');
      emit(createDeviceStates.InitCreateDeviceState(surroundings));
    } catch(e, stack) {
      log('error in fetching surroundings ${e.toString()}');
      log('error in fetching surroundings stacktrace ${stack.toString()}');
    }
  }

  Future<void> _createDevice(CreateDeviceEvent event, Emitter<createDeviceStates.CreateState> emit) async {
    try {
      final Environment currentEnvironment = await _homeRepository.getCurrentEnvironment(Environment(uuid: '', name: '', isCurrentEnvironment: false));
      final DataResponse<CreateDeviceResponse, uiStates.DataError> createDeviceResponse = await _deviceRepository.createDevice(event.deviceId, currentEnvironment.uuid, event.surroundingId);
      if(createDeviceResponse.success) {
        final createDevice = createDeviceResponse.data;
        if(createDevice?.isDeviceCreated ?? false) {
          final status = createDevice?.status ?? -1;
          emit(createDeviceStates.CreateDeviceState(status));
        }
      } else if(createDeviceResponse.error != null) {
        emit(createDeviceStates.CreateDeviceFailureState(createDeviceResponse.error?.message ?? ''));
      } else {
        emit(createDeviceStates.CreateDeviceFailureState('Failed in creating Device'));
      }
    } catch(e, stack) {
      log('error in creating Device ${e.toString()}');
      log('error in creating Device stacktrace ${stack.toString()}');
      emit(createDeviceStates.CreateDeviceFailureState(e.toString()));
    }
  }

  Future<void> _createSurroundingAndDevice(CreateSurroundingWithDeviceEvent event, Emitter<createDeviceStates.CreateState> emit) async {
    try {
      final Environment currentEnvironment = await _homeRepository.getCurrentEnvironment(Environment(uuid: '', name: '', isCurrentEnvironment: false));
      // final surrounding = await _deviceRepository.createSurrounding(event.surroundingName, currentEnvironment.uuid);
      // if(surrounding != null) {
      //   final isDeviceCreated = await _deviceRepository.createDevice(event.deviceId, currentEnvironment.uuid, surrounding.uuid);
      //   if(isDeviceCreated) {
      //     emit(CreateDeviceState(true));
      //   } else {
      //     emit(CreateDeviceState(false));
      //   }
      // }
    } catch(e, stack) {
      log('error in creating Surrounding ${e.toString()}');
      log('error in creating Surrounding stacktrace ${stack.toString()}');
    }
  }
}