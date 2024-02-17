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
import 'package:sha/ui/bloc/NewDeviceBloc.dart';
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
  late NewDeviceBloc _newDeviceBloc;
  @override
  void initState() {
    super.initState();
    _newDeviceBloc = NewDeviceBloc(getIt.get(), getIt.get(), getIt.get());
    _newDeviceBloc.fetchSurroundings();
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
            )
          ],
        ),
      )
    );
  }

  Widget _buildSurroundingWidget() {
    return BlocProvider(
      create: (_) => _newDeviceBloc,
      child: BlocListener<NewDeviceBloc, UIState> (
        listener: (context, state) {},
        child: BlocBuilder<NewDeviceBloc, UIState>(builder: (context, state) {
          if(state is SuccessState) { 
            List<Surrounding> surroundings = state.data;
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