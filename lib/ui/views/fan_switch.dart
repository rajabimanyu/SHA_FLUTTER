import 'package:flutter/material.dart';

class FanSwitch extends StatelessWidget {
  const FanSwitch({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.isOn,
    required this.deviceName,
    required this.isLoading,
    required this.onToggleSwitch,
    required this.changeStep,
  });

  final int totalSteps;
  final int currentStep;
  final bool isOn;
  final String deviceName;
  final bool isLoading;
  final void Function(bool isOn) onToggleSwitch;
  final void Function(int step) changeStep;

  @override
  Widget build(BuildContext context) {
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
                isOn ? Icons.wind_power : Icons.mode_fan_off_outlined,
                color: isOn ? Colors.white : Colors.white12,
                size: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  deviceName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              isLoading
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
                              onChanged: (value) => changeStep(value.toInt()),
                              min: 0,
                              max: totalSteps.toDouble(),
                              divisions: totalSteps,
                            ),
                            const SizedBox(width: 16),
                            Switch(value: isOn, onChanged: onToggleSwitch),
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
}
