import 'package:flutter/material.dart';

import '../../models/thing.dart';

class FanSwitch extends StatefulWidget {
  final Thing thing;
  final void Function(String status, String deviceId, String id, String thingType, int currentStep, int totalStep) onFanSwitch;

  const FanSwitch({
    super.key,
    required this.thing,
    required this.onFanSwitch
  });

  @override
  State<StatefulWidget> createState() {
    return FanSwitchState();
  }
}

class FanSwitchState extends State<FanSwitch> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    IconData icon = widget.thing.status == "ON" ? Icons.wind_power : Icons.mode_fan_off_outlined;
    Color iconColor = widget.thing.status == "ON" ? Colors.white : Colors.white12;
    bool switchStatus = widget.thing.status == "ON" ? true : false;
    int currentStep = widget.thing.currentStep;
    int totalSteps = widget.thing.totalStep;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Fan",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              _isLoading
                  ? const SizedBox(
                      height: 40,
                      width: 40,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox(
                      height: 40,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          children: [
                            Slider(
                              value: currentStep.toDouble(),
                              onChanged: (value) => _adjustSteps(value),
                              min: 0,
                              max: totalSteps.toDouble(),
                              divisions: totalSteps,
                              onChangeEnd: (value) => _adjustSteps(value),
                            ),
                            const SizedBox(width: 16),
                            Switch(value: switchStatus, onChanged: (bool value) {
                              _toggleStatus(value);
                            }),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleStatus(bool status) {
    setState(() {
      _isLoading = true;
    });
    widget.onFanSwitch(
        status ? 'ON' : 'OFF',
        widget.thing.deviceID,
        widget.thing.id,
        widget.thing.thingType,
        widget.thing.currentStep,
        widget.thing.totalStep
    );
  }

  void _adjustSteps(double steps) {
    setState(() {
      _isLoading = true;
    });
    widget.onFanSwitch(
        widget.thing.status,
        widget.thing.deviceID,
        widget.thing.id,
        widget.thing.thingType,
        steps.toInt(),
        widget.thing.totalStep
    );
  }
}
