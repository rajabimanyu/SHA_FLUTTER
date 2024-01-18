import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sha/models/surrounding.dart';
import 'package:sha/ui/views/fan_switch.dart';
import 'package:sha/ui/views/toggle_switch.dart';

class SurroundingWidget extends StatefulWidget {
  final Surrounding surrounding;
  const SurroundingWidget({super.key, required this.surrounding});

  @override
  State<SurroundingWidget> createState() => _SurroundingWidgetState();
}

class _SurroundingWidgetState extends State<SurroundingWidget> {
  bool _isBulbOn = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    log(widget.surrounding.name);
    widget.surrounding;
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
