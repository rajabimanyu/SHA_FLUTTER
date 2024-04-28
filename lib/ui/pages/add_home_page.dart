import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/base/di/inject_config.dart';
import 'package:sha/models/environment.dart';
import 'package:sha/ui/bloc/add_home_bloc.dart';
import 'package:sha/ui/bloc/events/add_home_events.dart';
import 'package:sha/ui/bloc/states/add_home_state.dart';
import 'package:sizer/sizer.dart';

import '../../route/routes.dart';
import '../views/loader.dart';

class AddHomePage extends StatefulWidget {
  const AddHomePage({super.key});

  @override
  State<AddHomePage> createState() => AddHomePageState();
}

class AddHomePageState extends State<AddHomePage> {
  late AddHomeBloc addHomeBloc;
  late AddHomeBloc mainHomeBloc;
  @override
  void initState() {
    log('init state ');
    super.initState();
    addHomeBloc = AddHomeBloc(getIt.get(), getIt.get());
    mainHomeBloc = AddHomeBloc(getIt.get(), getIt.get())..add(FetchHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Add Home')),
        body: _buildHomesWidget()
    );
  }

  Widget _buildHomesWidget() {
    return BlocProvider(
        create: (_) => mainHomeBloc,
      child: BlocListener<AddHomeBloc, AddHomeState> (
        listener: (context, state) {
          if(state is InitialState) {
            showLoaderDialog(context);
          }
        },
        child: BlocBuilder<AddHomeBloc, AddHomeState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Column(
                  children: [
                    Expanded(
                        child: _homesListWidget(state)
                        ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(onPressed: () {
                              // _showLoaderDialog(context);
                              // context.read<AddHomeBloc>().add(CreateHomeEvent(selectedSurroundingId, codeData));
                              _showAddHomeDialog('Enter Home Name', onPositiveButtonClicked: () => {

                              }, onNegativeButtonClicked: () => {

                              });
                            }, style: Theme.of(context).elevatedButtonTheme.style, child: const Text('Add Home'))
                        ))
                  ]
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _homesListWidget(AddHomeState state) {
    log('all bloc');
    if(state is FetchEnvState) {
      List<Environment> homes = state.environments;
      log('all surr = ${homes}');
      return ListView.builder(
          itemCount: homes.length,
          itemBuilder: (BuildContext context, int position) {
            log('spec surr = ${homes[position].name} &');
            return  GestureDetector(
                onTap: () {
                  // setState(() {
                  //   selectedIndex = position;
                  // });
                  // selectedSurroundingId = surroundings[position].uuid;
                },
                child:Container(
                  decoration: BoxDecoration( //                    <-- BoxDecoration
                    border: Border(bottom: BorderSide()),
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(
                          '${homes[position].name} dsfsdfdfsfsdfsdfsdfsdf',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                          )),
                      ),
                      if(homes[position].isCurrentEnvironment)
                        IconButton(
                          onPressed: () {},
                          icon:Icon(
                            Icons.star,
                            color: Theme.of(context).buttonTheme.colorScheme?.primary ?? Colors.blue,
                            size: 16,
                          ),
                          highlightColor: Theme.of(context).buttonTheme.colorScheme?.background ?? Colors.blue,
                        )
                      else
                        _switchHomeWidget(homes, position),
                      _deleteWidget(homes, position),
                      // if(selectedIndex == position) Icon(
                      //   Icons.done,
                      //   color: Colors.blue,
                      //   size: 32,
                      // )
                    ],
                  ),
                )
            );
          });
    } else if(state is AddHomeFailureState) {
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

  void _showConsent(String title, String message, {required Function() onPositiveButtonClicked,required Function() onNegativeButtonClicked}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(
                message,
                style: TextStyle(
                    fontSize: 20
                )),
            actions: <Widget>[
              MaterialButton(
                color: Theme.of(context).buttonTheme.colorScheme?.background,
                textColor: Theme.of(context).buttonTheme.colorScheme?.primary,
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                  onNegativeButtonClicked();
                },
              ),
              MaterialButton(
                color: Theme.of(context).buttonTheme.colorScheme?.background,
                textColor: Theme.of(context).buttonTheme.colorScheme?.primary,
                child: const Text('Proceed'),
                onPressed: () {
                  Navigator.pop(context);
                  onPositiveButtonClicked();
                },
              ),
            ],
          );
        });
  }

  final TextEditingController _textFieldController = TextEditingController();
  String? valueText;
  void _showAddHomeDialog(String title, {required Function() onPositiveButtonClicked,required Function() onNegativeButtonClicked}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'John'),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Theme.of(context).buttonTheme.colorScheme?.background,
                textColor: Theme.of(context).buttonTheme.colorScheme?.primary,
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                  onNegativeButtonClicked();
                },
              ),
              MaterialButton(
                color: Theme.of(context).buttonTheme.colorScheme?.background,
                textColor: Theme.of(context).buttonTheme.colorScheme?.primary,
                child: const Text('Proceed'),
                onPressed: () {
                  Navigator.pop(context);
                  onPositiveButtonClicked();
                },
              ),
            ],
          );
        });
  }

  void _showLoader() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Processing...'),
            content: Text(
                'Processing...',
                style: TextStyle(
                    fontSize: 20
                )),
          );
        });
  }

  Widget _deleteWidget(List<Environment> homes, int position) {
    BuildContext? dialogContext;
    log('delete renbder');
    return BlocProvider(
        create: (_) => AddHomeBloc(getIt.get(), getIt.get()),
        child: BlocListener<AddHomeBloc, AddHomeState>(
            listener: (context, state) {
              log('delete listen');
              if (state is DeleteHomeState) {
                  if (state.isDeleted) {
                    if(state.isCurrentEnvironment) {
                      Navigator.of(context).popUntil((route) =>
                      route.settings.name ==
                          ShaRoutes.homePageRoute);
                      Navigator.of(context)
                          .popAndPushNamed(ShaRoutes.homePageRoute);
                    } else {
                      if (isThereCurrentDialogShowing(context)) {
                        Navigator.pop(context);
                      }
                      mainHomeBloc.add(FetchHomeEvent());
                    }
                  }
              }
            }, child: BlocBuilder<AddHomeBloc, AddHomeState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                log("swicth home click");
                if(homes[position].isCurrentEnvironment) {
                  _showConsent('Please Confirm', 'Deleting default Home - ${homes[position].name} will switch to next home automatically', onPositiveButtonClicked : () => {
                    proceedDelete(homes[position], context.read<AddHomeBloc>())
                  }, onNegativeButtonClicked: () => {});
                } else {
                  _showConsent('Please Confirm', 'Are you sure want to delete Home - ${homes[position].name}', onPositiveButtonClicked : () => {
                    proceedDelete(homes[position], context.read<AddHomeBloc>())
                  }, onNegativeButtonClicked: () => {});
                }
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context)
                    .buttonTheme
                    .colorScheme
                    ?.primary ??
                    Colors.blue,
                size: 28,
              ),
              highlightColor: Theme.of(context)
                  .buttonTheme
                  .colorScheme
                  ?.inversePrimary ??
                  Colors.lightBlue,
            );
          },
        )));
  }

  void proceedDelete(Environment environment, AddHomeBloc deleteHomeBloc) {
    deleteHomeBloc.add(DeleteHomeEvent(envId: environment.uuid,isCurrentEnvironment: environment.isCurrentEnvironment));
    _showLoader();
  }

  Widget _switchHomeWidget(List<Environment> homes, int position) {
    return BlocProvider(
        create: (_) => addHomeBloc,
        child: BlocListener<AddHomeBloc, AddHomeState>(
            listener: (context, state) {
              if (state is SwitchHomeState) {
                if (state.isSwitched) {
                  Navigator.of(context).popUntil((route) =>
                  route.settings.name ==
                      ShaRoutes.homePageRoute);
                  Navigator.of(context)
                      .popAndPushNamed(ShaRoutes.homePageRoute);
                }
              }
            }, child: BlocBuilder<AddHomeBloc, AddHomeState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                  log("swicth home click");
                  _showConsent('Oops', 'Are you sure want to switch your Home', onPositiveButtonClicked : () => {
                  addHomeBloc.add(SwitchHomeEvent(envId: homes[position].uuid))
                }, onNegativeButtonClicked: () => {
                  Navigator.pop(context)
                });
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context)
                    .buttonTheme
                    .colorScheme
                    ?.primary ??
                    Colors.blue,
                size: 28,
              ),
              highlightColor: Theme.of(context)
                  .buttonTheme
                  .colorScheme
                  ?.inversePrimary ??
                  Colors.lightBlue,
            );
          },
        )));
  }
}