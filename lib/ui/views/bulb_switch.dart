import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sha/models/thing.dart';
import 'package:sha/ui/views/toggle_switch.dart';

class BulbSwitch extends StatefulWidget {
  final Thing thing;
  const BulbSwitch({Key? key, required this.thing}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BulbSwitchState();
  }
}

class BulbSwitchState extends State<BulbSwitch> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    IconData icon = widget.thing.status == "ON" ? Bulb.iconOn : Bulb.iconOff;
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
                  "Bulb",
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
  }
}