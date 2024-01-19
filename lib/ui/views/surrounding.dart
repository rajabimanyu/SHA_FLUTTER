import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/models/device.dart';
import 'package:sha/models/surrounding.dart';
import 'package:sha/ui/cubit/HomeCubit.dart';
import 'package:sha/ui/views/fan_switch.dart';
import 'package:sha/ui/views/toggle_switch.dart';
import 'package:sizer/sizer.dart';

import '../../core/model/ui_state.dart';

class SurroundingWidget extends StatefulWidget {
  final Surrounding surrounding;
  final HomeCubit homeCubit;
  const SurroundingWidget({super.key, required this.surrounding, required this.homeCubit});

  @override
  State<SurroundingWidget> createState() => _SurroundingWidgetState();
}

class _SurroundingWidgetState extends State<SurroundingWidget> {
  bool _isBulbOn = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    log("surr : ${widget.surrounding.name}");
    widget.homeCubit.fetchDeviceData(widget.surrounding.uuid);
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => widget.homeCubit,
        child: BlocListener<HomeCubit, UIState>(
          listener: (context, state) {
            if ((state is SuccessState<List<Device>> && state.data.isEmpty) || (state is FailureState)) {
              log('Homebloc devices empty: $state');
            }
          },
          child: BlocBuilder<HomeCubit, UIState>(builder: (context, state) {
            if(state is SuccessState) {
              log('Devices bloc success');
              return DevicesWidget();
            } else if(state is FailureState) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "Something went wrong. Please try again later.",
                  style: TextStyle(fontSize: 11.sp),
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
          }),
        ));
  }

  Widget DevicesWidget() {
    return Center(
      child: Column(
        children: [
          ToggleSwitch(
            deviceName: 'Bulb 1',
            isOn: _isBulbOn,
            isLoading: _isLoading,
            toggleSwitchType: Bulb(),
            onToggleSwitch: _toggleBulbState,
          ),
          const SizedBox(height: 24),
          FanSwitch(
            totalSteps: 5,
            currentStep: _currentFanStep,
            isOn: _isFanOn,
            deviceName: 'Bedroom Fan',
            isLoading: _isFanLoading,
            onToggleSwitch: _toggleFanState,
            changeStep: _changeFanStep,
          ),
        ],
      ),
    );
  }
}
