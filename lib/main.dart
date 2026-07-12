import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_information/presentation/home_page.dart';
import 'package:flutter_apps/service_locator.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';

void main() {
    print('check number of calls to main method');
  runZonedGuarded(() {
    //Method to handle async and sync errors in Flutter
    loadDependencies();
    runApp(MaterialApp(
      title: 'Math App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'गणितज्ञ'),
    ));
  }, (error, stack) {
    print('error: $error \n stack: $stack');
  });
}
