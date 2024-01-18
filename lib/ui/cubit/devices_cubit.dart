import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/core/model/ui_state.dart';

import '../../data/repository/environments_repository.dart';

class DeviceCubit extends Cubit<UIState> {
  final EnvironmentsRepository _environmentsRespository;
  DeviceCubit(this._environmentsRespository): super(InitialState());

  void fetchDevicesData(String surroundingId) async {
    emit(LoadingState());

  }
}