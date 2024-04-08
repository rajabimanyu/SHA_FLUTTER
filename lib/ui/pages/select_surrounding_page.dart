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
import 'package:sha/route/routes.dart';
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
  String codeData = '';
  int selectedIndex = 0;
  String selectedSurroundingId = "";

  final NewDeviceBloc newDeviceBlocInit = NewDeviceBloc(getIt.get(), getIt.get(), getIt.get());
  final NewDeviceBloc newDeviceBlocCreateDevice = NewDeviceBloc(getIt.get(), getIt.get(), getIt.get());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    codeData = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    log("qr data : $codeData");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Surrounding')),
        body: _buildSurroundingWidget()
    );
  }

  Widget _buildSurroundingWidget() {
    return BlocProvider(
      create: (_) => NewDeviceBloc(getIt.get(), getIt.get(), getIt.get()),
      child: BlocListener<NewDeviceBloc, CreateState> (
        listener: (context, state) {
          if(state is CreateDeviceState) {
            if(state.status == 1 || state.status == 3)  {
              Navigator.of(context).popAndPushNamed(ShaRoutes.connectDeviceRoute);
            } else if(state.status == 2){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Some Error occured, Please try again'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          } else if(state is CreateDeviceFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Some Error occured, Please try again'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        child: BlocBuilder<NewDeviceBloc, CreateState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Expanded(
                      child: BlocProvider(create: (_) => newDeviceBlocInit..add(const InitNewDeviceEvent()),
                          child: BlocListener<NewDeviceBloc, CreateState> (
                              listener: (context, state) {}, child: BlocBuilder<NewDeviceBloc, CreateState>(
                              bloc: newDeviceBlocInit,
                              builder: (context, state) {
                                log("came to second : $state");
                                return _surroundingListWidget(state);
                              })
                          )
                      )),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(onPressed: () {
                            _showLoaderDialog(context);
                            context.read<NewDeviceBloc>().add(CreateDeviceEvent(selectedSurroundingId, codeData));
                          }, style: Theme.of(context).elevatedButtonTheme.style, child: const Text('Proceed'))
                      ))
                ],
              ),
            );
          },
        )
           
        )
      );
  }


  
  Widget _surroundingListWidget(CreateState state) {
    log('all bloc');
    if(state is InitCreateDeviceState) {
      List<Surrounding> surroundings = state.surroundings;
      log('all surr = ${surroundings}');
      return ListView.builder(
          itemCount: surroundings.length,
          itemBuilder: (BuildContext context, int position) {
            log('spec surr = ${surroundings[position].name} & $selectedIndex');
            return  GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = position;
                  });
                  selectedSurroundingId = surroundings[position].uuid;
                },
                child:Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(
                          surroundings[position].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          )),
                      ),
                      if(selectedIndex == position) Icon(
                        Icons.done,
                        color: Colors.blue,
                        size: 32,
                      )
                    ],
                  ),
                )
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
  }

  _showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 20),child:Text("Processing..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  final TextEditingController _textFieldController = TextEditingController();
  String? codeDialog;
  String? valueText;
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Create new surrounding & map device'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration:
              const InputDecoration(hintText: 'Surrounding name'),
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
                child: const Text('Create'),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                  });
                  BlocProvider.of<NewDeviceBloc>(context).add(CreateSurroundingWithDeviceEvent(valueText ?? '', codeData ?? ''));
                },
              ),
            ],
          );
        });
  }
}