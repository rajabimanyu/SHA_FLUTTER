
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sha/ui/views/surrounding.dart';

import '../../core/model/ui_state.dart';
import '../../models/surrounding.dart';
import 'home_page_drawer.dart';

class TabHome extends StatefulWidget {
  final UIState state;
  const TabHome({Key? key, required this.state}) : super(key: key);

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
            // const [
            //   Tab(
            //     text: 'Bed Room',
            //   ),
            //   Tab(
            //     text: 'Living Room',
            //   ),
            //   Tab(
            //     text: 'Dining Room',
            //   ),
            //   Tab(
            //     text: 'Study',
            //   ),
            //   Tab(
            //     text: 'Basement',
            //   ),
            //   Tab(
            //     text: 'Terrace',
            //   ),
            //   Tab(
            //     text: 'Porch',
            //   ),
            // ],
          ),
        ),
        drawer: const HomePageDrawer(),
        body: TabBarView(
          controller: tabController,
          children: List.generate(surroundings.length, (index) =>
              const SurroundingWidget()
          ),
        ),
      ),
    );
  }
}