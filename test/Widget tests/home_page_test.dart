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
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: 'Flutter Demo Home Page',
        ),
      ),
    );
    //home page widget test
    expect(find.byKey(const ValueKey('StartGame')), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Replay'), findsOneWidget);
    expect(find.byIcon(Icons.wifi_protected_setup), findsOneWidget);
    expect(find.text('Check'), findsOneWidget);
    expect(find.text('+ (addition)'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('1'), findsNWidgets(1));
    expect(find.text('2'), findsNWidgets(1));
    await tester.tap(find.byKey(const ValueKey('HomePageFloatingActionButton')));
    await tester.pump();
    //Game parameters widget test
    expect(find.text('Number of digits: '), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_rounded), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward_ios_rounded), findsOneWidget);
    for (int i = 0; i < 4; i++) {
      await tester.tap(find.byIcon(Icons.arrow_forward_ios_rounded));
    }
    expect(find.text('+'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('X'), findsOneWidget);
    expect(find.text('÷'), findsOneWidget);
    await tester.tap(find.text('÷'));
    await tester.pump();
    expect(find.text('÷ (division)'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
    expect(find.text('Exit'), findsOneWidget);
    await tester.tap(find.text('Exit'));
    await tester.pump();
    //Home page widget test
    expect(find.text('6'), findsNWidgets(1));
  });
}
