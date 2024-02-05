import 'package:sha/data/repository/NewDeviceRepository.dart';

import '../../data/repository/environments_repository.dart';

class AddDeviceViewModel {
  final NewDeviceRepository _newDeviceRepository;
  const AddDeviceViewModel(this._newDeviceRepository);

  void createEnvironment(String envName) {
    _newDeviceRepository.createEnvironment(envName);
  }
}