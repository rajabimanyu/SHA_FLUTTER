import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/models/environment.dart';
import 'package:sha/ui/bloc/events/add_home_events.dart';
import 'package:sha/ui/bloc/states/add_home_state.dart';

import '../../data/repository/home_repository.dart';

class AddHomeBloc extends Bloc<AddHomeEvent, AddHomeState> {
  final HomeRepository _homeRepository;
  AddHomeBloc(this._homeRepository) : super(const InitialState()) {
    on<FetchHomeEvent>(_fetchEnvironments);
  }

  Future<void> _fetchEnvironments(FetchHomeEvent event, Emitter<AddHomeState> emit) async {
    try {
      final List<Environment> environments = await _homeRepository.fetchEnvironments(isOffline: true);
      if(environments.isNotEmpty) {
        emit(FetchEnvState(environments: environments));
      } else {
        emit(FetchEnvState(environments: environments));
      }
    } catch(e, stack) {
      log('error in fetching environments ${e.toString()}');
      log('error in fetching environments stacktrace ${stack.toString()}');
    }
  }

  Future<void> _switchEnvironment(SwitchHomeEvent event, Emitter<AddHomeState> emit) async {
    try {

    } catch(e, stack) {
      log('error in switching environments ${e.toString()}');
      log('error in switching environments stacktrace ${stack.toString()}');
    }
  }

}