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
  int selectedIndex = 0;
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
        title: const Text('Select a Surrounding'), actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).iconTheme.color
            ),
            onPressed: () {
              _displayTextInputDialog(context);
            },
          )
        ]),
        body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Expanded(
              child: _buildSurroundingWidget(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(onPressed: () {}, style: Theme.of(context).elevatedButtonTheme.style, child: const Text('Create Surrounding'))
              )),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(onPressed: () {}, style: Theme.of(context).elevatedButtonTheme.style, child: const Text('Proceed'))
            ))
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
          log('all bloc');
          if(state is InitCreateDeviceState) {
            List<Surrounding> surroundings = state.surroundings;
            surroundings.add(Surrounding(uuid: "1",name: "value 1"));
            surroundings.add(Surrounding(uuid: "2",name: "value 2"));
            surroundings.add(Surrounding(uuid: "3",name: "value 3"));
            surroundings.add(Surrounding(uuid: "4",name: "value 4"));
            surroundings.add(Surrounding(uuid: "5",name: "value 5"));
            surroundings.add(Surrounding(uuid: "6",name: "value 6"));
            surroundings.add(Surrounding(uuid: "7",name: "value 7"));
            surroundings.add(Surrounding(uuid: "8",name: "value 8"));
            surroundings.add(Surrounding(uuid: "9",name: "value 9"));
            surroundings.add(Surrounding(uuid: "10",name: "value 10"));
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
                    },
                    child:Container(
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
        })
      ));
  }

  final TextEditingController _textFieldController = TextEditingController();
  String? codeDialog;
  String? valueText;
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Create new surrounding'),
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
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}