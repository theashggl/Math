import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_information/presentation/home_page.dart';
import 'package:flutter_apps/service_locator.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/widgets/home_page_inherited_widget.dart';

void main() {
    print('check number of calls to main method');
  runZonedGuarded(() {
    final NavigatorObserver navigatorObserver=NavigatorObserver();
    //Method to handle async and sync errors in Flutter
    final GameLogic gameLogic = GameLogic();
    print('check number of calls to runZonedGuarded');
    configureDependencies();
    runApp(HomePageInheritedWidget(
      gameObject: gameLogic,
      child: MaterialApp(
        navigatorObservers: [navigatorObserver],
        title: 'Math App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'गणितज्ञ'),
      ),
    ));
  }, (error, stack) {
    print('error: $error \n stack: $stack');
  });
}
