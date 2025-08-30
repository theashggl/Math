import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_apps/UI/home_page.dart';

void main() {
  runZonedGuarded(() {//Method to handle async and sync errors in Flutter
    runApp(MaterialApp(
        title: 'Math App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'गणितज्ञ'),));
  }, (error, stack) {
    print('error: $error \n stack: $stack');
  });
}
