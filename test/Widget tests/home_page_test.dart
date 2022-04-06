// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_apps/UI/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Material App Widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final materialApp = find.byKey(const ValueKey('StartGame'));
    final floatingActionButton =
        find.byKey(const ValueKey('HomePageFloatingActionButton'));
    // Verify that our counter starts at 0.
    await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(
      title: 'Flutter Demo Home Page',
    )));
    // await tester.pump();
    // expect(find.text('Digits:'), findsOneWidget);
    expect(materialApp, findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Replay'), findsOneWidget);
    expect(find.byIcon(Icons.wifi_protected_setup), findsOneWidget);
    expect(find.text('Check'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
    await tester.tap(floatingActionButton);
    await tester.pump();
    expect(find.text('Number of Inputs '), findsOneWidget);
    expect(find.text('Enter the number of occurrences'), findsOneWidget);
    expect(find.text('ABC'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_rounded), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward_ios_rounded), findsOneWidget);
  });
}
