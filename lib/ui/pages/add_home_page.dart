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
  final AddHomeBloc addHomeBloc = AddHomeBloc(getIt.get(), getIt.get());
  @override
  void initState() {
    super.initState();
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
        create: (_) => AddHomeBloc(getIt.get(), getIt.get())..add(FetchHomeEvent()),
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
                            }, style: Theme.of(context).elevatedButtonTheme.style, child: const Text('Proceed'))
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
                      IconButton(onPressed: (){},
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).buttonTheme.colorScheme?.inversePrimary ?? Colors.blue,
                          size: 28,
                        ),
                        highlightColor: Theme.of(context).buttonTheme.colorScheme?.primary ?? Colors.lightBlue,
                      ),
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
                  setState(() {
                    onNegativeButtonClicked();
                  });
                },
              ),
              MaterialButton(
                color: Theme.of(context).buttonTheme.colorScheme?.background,
                textColor: Theme.of(context).buttonTheme.colorScheme?.primary,
                child: const Text('Proceed'),
                onPressed: () {
                  onPositiveButtonClicked();
                },
              ),
            ],
          );
        });
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

  Widget _deleteHomeWidget(List<Environment> homes, int position) {
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
                addHomeBloc.add(SwitchHomeEvent(
                    envId: homes[position].uuid));
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