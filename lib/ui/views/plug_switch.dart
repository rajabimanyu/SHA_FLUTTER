
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sha/models/thing.dart';
import 'package:sha/ui/views/toggle_switch.dart';

class PlugSwitch extends StatefulWidget {
  final Thing thing;
  final void Function(String status, String deviceId, String id, String thingType, int currentStep, int totalStep) onPlugSettingsChanged;
  const PlugSwitch({Key? key, required this.thing, required this.onPlugSettingsChanged}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PlugSwitchState();
  }
}

class PlugSwitchState extends State<PlugSwitch> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    IconData icon = widget.thing.status == "ON" ? Plug.iconOn : Plug.iconOff;
    Color iconColor = widget.thing.status == "ON" ? Colors.white : Colors.white12;
    bool switchStatus = widget.thing.status == "ON" ? true : false;
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
                color: iconColor,
                size: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Plug",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Switch(value: switchStatus, onChanged: (bool value) {
                    log("switch value $value");
                    _toggleStatus(value);
                  }),
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
    widget.onPlugSettingsChanged(
        status ? 'ON' : 'OFF',
        widget.thing.deviceID,
        widget.thing.id,
        widget.thing.thingType,
        widget.thing.currentStep,
        widget.thing.totalStep
    );
  }
}