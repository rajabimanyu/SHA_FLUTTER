import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sha/base/boxes.dart';
import 'package:sha/base/di/inject_config.dart';
import 'package:sha/models/device.dart';
import 'package:sha/models/surrounding.dart';
import 'package:sha/models/thing.dart';
import 'package:sha/ui/cubit/devices_cubit.dart';
import 'package:sha/ui/views/bulb_switch.dart';
import 'package:sha/ui/views/fan_switch.dart';
import 'package:sha/ui/views/toggle_switch.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../base/ShaConstants.dart';
import '../../core/model/ui_state.dart';

class SurroundingWidget extends StatefulWidget {
  final Surrounding surrounding;
  final List<String> fetchedSurroundings;
  const SurroundingWidget({super.key, required this.surrounding, required this.fetchedSurroundings});

  @override
  State<SurroundingWidget> createState() => _SurroundingWidgetState();
}

class _SurroundingWidgetState extends State<SurroundingWidget> {
  bool _isBulbOn = false;
  bool _isLoading = false;
  late DeviceCubit deviceCubit;
  final List<Thing> things = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    log("surr : ${widget.surrounding.name}");
    _initDevices();
    deviceCubit = DeviceCubit(getIt.get());
    if(!widget.fetchedSurroundings.contains(widget.surrounding.uuid)) {
      deviceCubit.fetchDeviceData(widget.surrounding.uuid);
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceBox.watch(key: widget.surrounding.uuid).listen((event) {
      log("events : ${event.value}");
      final List<Device> devices = (event.value ?? List.empty(growable: true)).cast<Device>();
      _setThings(devices);
    });
    return DevicesWidget();
  }

  Widget DevicesWidget() {
    return BlocProvider(
        create: (_) => deviceCubit,
        child: BlocListener<DeviceCubit, UIState>(
          listener: (context, state) {
            if (state is SuccessState) {
              log('Devices fetch Success');
              widget.fetchedSurroundings.add(widget.surrounding.uuid);
            }
          },
          child: BlocBuilder<DeviceCubit, UIState>(builder: (context, state) {
            if(state is SuccessState) {
              return ListView.builder(
                  itemCount: things.length,
                  itemBuilder: (BuildContext context, int position) {
                    return BulbSwitch(thing: things[position]);
                  });
            } else if(state is FailureState) {
              return SnackBar(
                content: Text((state.error as UiError).message),
                backgroundColor: Theme.of(context).colorScheme.error,
              );
            }
          }),
        ));
    deviceCubit.stream.listen((event) {
      if (event is SuccessState) {
        log('Devices fetch Success');
        widget.fetchedSurroundings.add(widget.surrounding.uuid);
      }
    });
    if (things.isNotEmpty) {
      return ListView.builder(
          itemCount: things.length,
          itemBuilder: (BuildContext context, int position) {
            return BulbSwitch(thing: things[position]);
          });
    } else {
      return Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }
  }

  void _initDevices() {
    final List<Device> devicesFromDB = (deviceBox.get(widget.surrounding.uuid) ?? List.empty(growable: true)).cast<Device>();
    _setThings(devicesFromDB);
  }

  void _setThings(List<Device> devices) {
    final List<Thing> thingsFromDB = List.empty(growable: true);
    for (var element in devices) {
      thingsFromDB.addAll(element.things);
    }
    if (thingsFromDB.isNotEmpty) {
      things.clear();
      setState(() {
        things.addAll(thingsFromDB);
      });
    }
  }

  void _toggleBulbState(bool isOn) async {
    setState(() {
      _isLoading = true;
    });
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        _isBulbOn = isOn;
      });
    });
  }

  bool _isFanOn = false;
  bool _isFanLoading = false;
  int _currentFanStep = 0;

  void _toggleFanState(bool isOn) async {
    setState(() {
      _isFanLoading = true;
    });
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _isFanLoading = false;
        _isFanOn = isOn;
      });
    });
  }

  void _changeFanStep(int step) async {
    setState(() {
      _isFanLoading = true;
    });
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _isFanLoading = false;
        _currentFanStep = step;
      });
    });
  }
}
