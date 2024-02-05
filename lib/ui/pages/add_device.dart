import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});
  
  @override
  State<AddDevicePage> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevicePage> {
  String? codeData;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    codeData = ModalRoute.of(context)?.settings.arguments as String?;
    log("qr data : $codeData");
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Device'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Text(
          'Welcome! Sign in to control your home at a snap.',
          style:
          TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
        ),
      )
    );
  }
}