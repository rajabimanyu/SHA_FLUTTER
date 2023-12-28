import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  const ToggleSwitch({
    super.key,
    required this.deviceName,
    required this.isOn,
    required this.isLoading,
    required this.toggleSwitchType,
    required this.onToggleSwitch,
  });

  final String deviceName;
  final bool isOn;
  final bool isLoading;
  final ToggleSwitchType toggleSwitchType;
  final void Function(bool isOn) onToggleSwitch;

  IconData get icon => switch (toggleSwitchType) {
        Bulb() => isOn ? Bulb.iconOn : Bulb.iconOff,
        Fan() => Fan.icon,
        Light() => isOn ? Light.iconOn : Light.iconOff,
        Plug() => Plug.icon,
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              SizedBox(
                height: 40,
                width: 40,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Switch(value: isOn, onChanged: onToggleSwitch),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Add required icons here
sealed class ToggleSwitchType {}

class Bulb extends ToggleSwitchType {
  static const iconOn = Icons.wb_incandescent;
  static const iconOff = Icons.lightbulb_outline;
}

class Fan extends ToggleSwitchType {
  static const icon = Icons.mode_fan_off;
}

class Light extends ToggleSwitchType {
  static const iconOn = Icons.light;
  static const iconOff = Icons.light_outlined;
}

class Plug extends ToggleSwitchType {
  static const icon = Icons.power_settings_new;
}
