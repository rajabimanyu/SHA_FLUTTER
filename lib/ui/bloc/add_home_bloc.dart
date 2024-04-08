import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/models/environment.dart';
import 'package:sha/ui/bloc/events/add_home_events.dart';
import 'package:sha/ui/bloc/states/add_home_state.dart';

import '../../data/repository/environments_repository.dart';

class AddHomeBloc extends Bloc<AddHomeEvent, AddHomeState> {
  final HomeRepository _homeRepository;
  AddHomeBloc(this._homeRepository) : super(const FetchHomeEvent() as AddHomeState) {
    on<FetchHomeEvent>(_fetchEnvironments as EventHandler<FetchHomeEvent, AddHomeState>);

  }

  Future<void> _fetchEnvironments(Emitter<FetchEnvState> emit) async {
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

}