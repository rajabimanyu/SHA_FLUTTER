
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sha/models/thing.dart';
import 'package:sha/ui/views/toggle_switch.dart';

class LightSwitch extends StatefulWidget {
  final Thing thing;
  final void Function(String status, String deviceId, String id, String thingType, int currentStep, int totalStep) onLightSwitch;
  const LightSwitch({Key? key, required this.thing, required this.onLightSwitch}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LightSwitchState();
  }
}

class LightSwitchState extends State<LightSwitch> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    IconData icon = widget.thing.status == "ON" ? Light.iconOn : Light.iconOff;
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
                  "Light",
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
                    _setLoading(true);
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
    widget.onLightSwitch(
        widget.thing.status,
        widget.thing.deviceID,
        widget.thing.id,
        widget.thing.thingType,
        widget.thing.currentStep,
        widget.thing.totalStep
    );
  }
}