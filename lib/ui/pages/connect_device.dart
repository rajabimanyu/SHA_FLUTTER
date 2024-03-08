import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wifi_scan/wifi_scan.dart';

class ConnectDevicePage extends StatefulWidget {
  const ConnectDevicePage({super.key});

  @override
  State<ConnectDevicePage> createState() => _ConnectDevicePage();
}

class _ConnectDevicePage extends State<ConnectDevicePage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _startListeningToScanResults(context);
  }

  List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;

  bool get isStreaming => subscription != null;

  Future<bool> _canGetScannedResults(BuildContext context) async {
    final can = await WiFiScan.instance.canGetScannedResults();
    if (can != CanGetScannedResults.yes) {
      if (mounted) showSnackbar(context, "Cannot get scanned results: $can");
      accessPoints = <WiFiAccessPoint>[];
      return false;
    }
    return true;
  }

  Future<void> _startListeningToScanResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      subscription = WiFiScan.instance.onScannedResultsAvailable
          .listen((result) => setState(() => accessPoints = result));
    }
  }

  void _stopListeningToScanResults() {
    subscription?.cancel();
    setState(() => subscription = null);
  }

  @override
  void dispose() {
    super.dispose();
    _stopListeningToScanResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Wifi'),
      ),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Center(
                  child: accessPoints.isEmpty
                      ? const Text("NO SCANNED RESULTS")
                      : ListView.builder(
                          itemCount: accessPoints.length,
                          itemBuilder: (context, i) =>
                              _wifiListWidget(accessPoints[i]),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _wifiListWidget(WiFiAccessPoint accessPoint) {
    final title = accessPoint.ssid.isNotEmpty ? accessPoint.ssid : "**EMPTY**";
    final signalIcon = accessPoint.level >= -80
        ? Icons.signal_wifi_4_bar
        : Icons.signal_wifi_0_bar;
    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: Icon(signalIcon),
      title: Text(title),
      subtitle: Text(accessPoint.capabilities),
      onTap: () => {_displayTextInputDialog(context, accessPoint.ssid)},
    );
  }

  final TextEditingController _textFieldController = TextEditingController();
  String? valueText;

  Future<void> _displayTextInputDialog(BuildContext context, String wifiSSID) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter wifi password to make device to connect with internet'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Theme.of(context).buttonTheme.colorScheme?.background,
                textColor: Theme.of(context).buttonTheme.colorScheme?.primary,
                child: const Text('Cancel'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                color: Theme.of(context).buttonTheme.colorScheme?.background,
                textColor: Theme.of(context).buttonTheme.colorScheme?.primary,
                child: const Text('Connect'),
                onPressed: () {
                  // send valueText here
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
