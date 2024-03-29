
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sha/ui/bloc/HomeCubit.dart';
import 'package:sha/ui/views/surrounding.dart';

import '../../core/model/ui_state.dart';
import 'package:sha/models/surrounding.dart';
import '../../route/routes.dart';
import 'home_page_drawer.dart';

class TabHome extends StatefulWidget {
  final UIState state;
  final HomeCubit homeCubit;
  const TabHome({Key? key, required this.state, required this.homeCubit}) : super(key: key);

  @override
  State<TabHome> createState() => TabHomePageState();
}

class TabHomePageState extends State<TabHome> with TickerProviderStateMixin {
  late TabController tabController;
  late List<Surrounding> surroundings;
  @override
  void initState() {
    super.initState();
    final SuccessState dashboardState = widget.state as SuccessState;
    surroundings = dashboardState.data as List<Surrounding>;
    tabController = TabController(initialIndex: 0, length: surroundings.length , vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return tabbedHomePage(context);
  }

  Widget tabbedHomePage(BuildContext context) {
    final theme = Theme.of(context);
    log('tab data : ');
    final List<String> fetchedSurroundings = List.empty(growable: true);
    return DefaultTabController(
      initialIndex: 0,
      length: tabController.length,
      child: Scaffold(
        appBar: AppBar(
          leading: const DrawerButton(),
          bottom: TabBar(
              controller: tabController,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              isScrollable: true,
              labelStyle: theme.textTheme.titleLarge,
              unselectedLabelStyle: theme.textTheme.titleSmall,
              physics: const ClampingScrollPhysics(),
              tabs: List.generate(surroundings.length, (index) =>
                  Tab(
                    text: surroundings[index].name,
                  ))
          ),
        ),
        drawer: const HomePageDrawer(),
        body: TabBarView(
          controller: tabController,
          children: List.generate(surroundings.length, (index) =>
              SurroundingWidget(surrounding: surroundings[index], fetchedSurroundings: fetchedSurroundings)
          ),
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: theme.floatingActionButtonTheme.backgroundColor,
            shape: const CircleBorder(),
            onPressed: (){
              Navigator.of(context).pushNamed(ShaRoutes.qrPageRoute);
            },
            child: const Icon(Icons.add)
        ),
      ),
    );
  }
}