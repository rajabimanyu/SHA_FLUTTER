import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sha/base/ShaConstants.dart';
import 'package:sha/base/boxes.dart';
import 'package:sha/base/di/inject_config.dart';
import 'package:sha/models/environment.dart';
import 'package:sha/models/surrounding.dart';
import 'package:sha/ui/bloc/events/create_device_events.dart';
import 'package:sha/ui/bloc/new_device_bloc.dart';
import 'package:sha/ui/bloc/states/create_device_state.dart';
import 'package:sha/util/ShaUtils.dart';
import 'package:sizer/sizer.dart';

import '../../core/model/ui_state.dart';

class SelectSurroundingPage extends StatefulWidget {
  const SelectSurroundingPage({super.key});
  
  @override
  State<SelectSurroundingPage> createState() => _SelectSurroundingState();
}

class _SelectSurroundingState extends State<SelectSurroundingPage> {
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
        title: Text('Select a Surrounding'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Expanded(
              child: _buildSurroundingWidget(),
            ),
            ListTile(
              //contentPadding: EdgeInsets.all(<some value here>),//change for side padding
              title: Row(
                children: <Widget>[
                  Expanded(child: ElevatedButton(onPressed: () {},child: Text("Clear"), style: Theme.of(context).elevatedButtonTheme.style)),
                  Expanded(child: ElevatedButton(onPressed: () {},child: Text("Filter"),style: Theme.of(context).elevatedButtonTheme.style))
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _buildSurroundingWidget() {
    return BlocProvider(
      create: (_) => NewDeviceBloc(getIt.get(), getIt.get(), getIt.get())..add(const InitNewDeviceEvent()),
      child: BlocListener<NewDeviceBloc, CreateState> (
        listener: (context, state) {},
        child: BlocBuilder<NewDeviceBloc, CreateState>(builder: (context, state) {
          if(state is InitCreateDeviceState) {
            List<Surrounding> surroundings = state.surroundings;
            log('all surr = ${surroundings}');
            return ListView.builder(
                itemCount: surroundings.length,
                itemBuilder: (BuildContext context, int position) {
                  log('spec surr = ${surroundings[position].name}');
                  return Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          surroundings[position].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                        Icon(
                          Icons.done,
                          color: Colors.blue,
                          size: 32,
                        )
                      ],
                    ),
                  );
                });
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
        })
      ));
  }
}