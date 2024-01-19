
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/base/di/inject_config.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/models/environment.dart';
import 'package:sha/models/surrounding.dart';
import 'package:sha/route/routes.dart';
import 'package:sha/ui/cubit/HomeCubit.dart';
import 'package:sha/ui/views/home_page_drawer.dart';
import 'package:sha/ui/views/surrounding.dart';
import 'package:sha/ui/views/tab_home.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    homeCubit = HomeCubit(getIt.get(), getIt.get());
    homeCubit.fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: buildHomeScreen(context)
    );

  }

  Widget buildHomeScreen(BuildContext context) {
    return BlocProvider(
        create: (_) => homeCubit,
        child: BlocListener<HomeCubit, UIState>(
          listener: (context, state) {
            log('Home Page bloc init: $state');
            if ((state is SuccessState<List<Surrounding>> && state.data.isEmpty) || (state is FailureState)) {
              log('Home Page bloc env empty: $state');
              Navigator.of(context).popAndPushNamed(ShaRoutes.qrPageRoute);
            }
          },
          child: BlocBuilder<HomeCubit, UIState>(builder: (context, state) {
            if(state is SuccessState) {
              log('Home Page bloc success');
              return TabHome(state: state, homeCubit: homeCubit);
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
          }),
        ));
  }
}
