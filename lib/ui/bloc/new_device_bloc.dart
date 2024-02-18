import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sha/base/ShaConstants.dart';
import 'package:sha/data/repository/environments_repository.dart';
import 'package:sha/data/repository/surroundings_repository.dart';
import 'package:sha/models/environment.dart';
import 'package:sha/models/surrounding.dart';
import 'package:sha/ui/bloc/events/create_device_events.dart';
import 'package:sha/ui/bloc/states/create_device_state.dart';
import 'package:sha/util/ShaUtils.dart';

import '../../data/repository/device_repository.dart';

class NewDeviceBloc extends Bloc<CreateEvent, CreateState> {
  final SurroundingsRepository _surroundingsRepository;
  final DeviceRepository _deviceRepository;
  final HomeRepository _homeRepository;
  NewDeviceBloc(
      this._surroundingsRepository,
      this._deviceRepository,
      this._homeRepository
      ): super(const InitialState()) {
    on<InitNewDeviceEvent>(_fetchSurroundings);
    on<CreateDeviceEvent>(_createDevice);
    on<CreateSurroundingWithDeviceEvent>(_createSurroundingAndDevice);
  }

  Future<void> _fetchSurroundings(InitNewDeviceEvent event, Emitter<CreateState> emit) async {
    try {
      final Environment currentEnvironment = await _homeRepository.getCurrentEnvironment(Environment(uuid: '', name: '', isCurrentEnvironment: false));
      final List<Surrounding> surroundings =await _surroundingsRepository.fetchSurroundings(currentEnvironment.uuid);
      emit(InitCreateDeviceState(surroundings));
    } catch(e, stack) {
      log('error in fetching surroundings ${e.toString()}');
      log('error in fetching surroundings stacktrace ${stack.toString()}');
    }
  }
// 9894088889
  Future<void> _createDevice(CreateDeviceEvent event, Emitter<CreateState> emit) async {
    try {
      final Environment currentEnvironment = await _homeRepository.getCurrentEnvironment(Environment(uuid: '', name: '', isCurrentEnvironment: false));
      final isDeviceCreated = await _deviceRepository.createDevice(event.deviceId, currentEnvironment.uuid, event.surroundingId);
      if(isDeviceCreated) {
        emit(CreateDeviceState(true));
      } else {
        emit(CreateDeviceState(false));
      }
    } catch(e, stack) {
      log('error in creating Device ${e.toString()}');
      log('error in creating Device stacktrace ${stack.toString()}');
    }
  }

  Future<void> _createSurroundingAndDevice(CreateSurroundingWithDeviceEvent event, Emitter<CreateState> emit) async {
    try {
      final Environment currentEnvironment = await _homeRepository.getCurrentEnvironment(Environment(uuid: '', name: '', isCurrentEnvironment: false));
      final surrounding = await _deviceRepository.createSurrounding(event.surroundingName, currentEnvironment.uuid);
      if(surrounding != null) {
        final isDeviceCreated = await _deviceRepository.createDevice(event.deviceId, currentEnvironment.uuid, surrounding.uuid);
        if(isDeviceCreated) {
          emit(CreateDeviceState(true));
        } else {
          emit(CreateDeviceState(false));
        }
      }
    } catch(e, stack) {
      log('error in creating Surrounding ${e.toString()}');
      log('error in creating Surrounding stacktrace ${stack.toString()}');
    }
  }
}