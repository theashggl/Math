import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_information/presentation/widgets/app_bar_home_page.dart';
import 'package:flutter_apps/features/game_information/presentation/widgets/body_home_page.dart';
import 'package:flutter_apps/features/game_parameters/presentation/floating_action_button_home_page.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/widgets/home_page_inherited_widget.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  //   late final AppLifecycleListener listener;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  print('Checking initstate calls');
  }
  //   listener = AppLifecycleListener(
  //     onResume: () => debugDumpApp(),
  //     onShow: () {
  //       print('show home page executed');
  //       debugDumpApp();
  //     },
  //     onHide: () {
  //       print('onHide executed');
  //     },
  //     onInactive: () {
  //       print('onInactive executed');
  //     },
  //     onPause: () {
  //       print('onPause executed');
  //     },
  //     onDetach: () {
  //       print('onDetach executed');
  //     },
  //     onRestart: () {
  //       print('onRestart executed');
  //     },
  //     onStateChange: (AppLifecycleState state)=>print('state changed for home page executed'),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    print('Check Scaffold calls');
    return Scaffold(
      appBar: AppBarOfScaffold(
        title: widget.title,
      ),
      body: const GameInformationBody(),
      floatingActionButton: const GameParameterDialog(),
    );
  }
}
