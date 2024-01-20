import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/core/model/ui_state.dart';

import '../../data/repository/environments_repository.dart';
import '../../models/device.dart';

class DeviceCubit extends Cubit<UIState> {
  final EnvironmentsRepository _environmentsRespository;
  DeviceCubit(this._environmentsRespository): super(InitialState());

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