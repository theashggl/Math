// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_information/presentation/home_page.dart';
import 'package:flutter_apps/features/game_numbers/domain/use_cases/number_display_functionalities.dart';
import 'package:flutter_apps/service_locator.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/widgets/home_page_inherited_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDIVariables extends Mock implements DIVariables {}

void main() {
  // late GameLogic gameLogic;
  late final MockDIVariables diVariables;
  final controller = StreamController<num>.broadcast();
  setUpAll(() {
    // gameLogic = GameLogic();
    diVariables = MockDIVariables();
    loadDependencies();
  });

  testWidgets('Material App Widget test', (WidgetTester tester) async {
    WidgetController.hitTestWarningShouldBeFatal = true;
    when(() => diVariables.selectedOperation)
        .thenReturn(SelectedOperation.divide);
    when(() => diVariables.streamsProcessorList).thenReturn([6, 2]);
    when(() => diVariables.streamController).thenReturn(controller);
    when(() => diVariables.testableRandomInt(99)).thenReturn(33);
    print('check random value: ${diVariables.testableRandomInt(99)}');
    // when(() => diVariables.inputOfGameNumbers.add(33))
    //     .thenAnswer((_) => controller.sink.add(99));
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: 'गणितज्ञ',
        ),
      ),
    );

    homePageTests();
    expect(find.text('+ (addition)'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('1'), findsNWidgets(1));
    expect(find.text('2'), findsNWidgets(1));
    //home page widget test
    await tester
        .tap(find.byKey(const ValueKey('HomePageFloatingActionButton')));
    await tester.pumpAndSettle();

    //Game parameters widget test
    //home page visibility tests
    homePageTests();
    expect(find.text('+ (addition)'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    //Game parameter screen test
    expect(find.text('Number of operands:'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_rounded), findsOneWidget);
    expect(find.text('2'), findsNWidgets(2));
    expect(find.byIcon(Icons.arrow_forward_ios_rounded), findsOneWidget);
    for (int i = 0; i < 4; i++) {
      await tester.tap(find.byIcon(Icons.arrow_forward_ios_rounded));
      await tester.pumpAndSettle();
    }
    expect(find.text('6'), findsNWidgets(2));
    expect(find.text('Select operation: '), findsOneWidget);
    expect(find.text('+'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('X'), findsOneWidget);
    expect(find.text('÷'), findsOneWidget);
    await tester.tap(find.text('÷'));
    await tester.pumpAndSettle();
    expect(find.text('Number of digits: '), findsOneWidget);
    expect(find.text('1'), findsNWidgets(2));
    final downwardArrow = find.byIcon(Icons.arrow_downward);
    expect(downwardArrow, findsOneWidget);
    await tester.tap(downwardArrow);
    await tester.pumpAndSettle();
    expect(
      find.text('1'),
      findsNWidgets(
        3,
      ),
    ); //Counting the previous page usage of this value too hence this has three instances. Two from the dropdown stacks and one from the previous page default value.
    expect(
      find.text('2'),
      findsOneWidget,
    );
    expect(
      find.text('3'),
      findsOneWidget,
    );
    expect(
      find.text('4'),
      findsOneWidget,
    );
    await tester.tap(find.text('2').last);

    when(() => diVariables.selectedOperation)
        .thenReturn(SelectedOperation.divide);
    when(() => diVariables.streamsProcessorList).thenReturn([6, 2]);

    await tester.pumpAndSettle();
    expect(find.text('2'), findsNWidgets(2));
    final submitButton = find.text('Submit');
    expect(submitButton, findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Exit'), findsOneWidget);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();
    homePageTests();
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    // await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Exit'));
    // Future.delayed(const Duration(seconds: 4));
    // controller.sink.add(23);
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    controller.close();
    await tester.tap(find.text('Exit'));
    expect(find.text('Exit'), findsOneWidget);
    await tester.pumpAndSettle();
    // await mockDIVariables.streamController.done;
//Todo fix the stream not closing on mock object making the test fail.
    await tester.tap(find.text('Exit'));
    await tester.pumpAndSettle();
    expect(find.text('Exit'), findsNothing);
    //Home page widget test
    homePageTests();
    expect(find.text('÷ (division)'), findsOneWidget);
    expect(find.text('1'), findsNWidgets(2));
    expect(find.text('6'), findsNWidgets(2));
    final match = find.text('Exit');
    print("evaluate: ${match.evaluate().length}");
    expect(match, findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}

void homePageTests() {
  expect(find.text('गणितज्ञ'), findsOneWidget);
  expect(find.text('Digits: '), findsOneWidget);
  expect(find.text('Count of operands: '), findsOneWidget);
  expect(find.byKey(const ValueKey('StartGame')), findsOneWidget);
  expect(find.text('Enter your number'), findsOneWidget);
  expect(find.byIcon(Icons.text_fields_rounded), findsOneWidget);
  expect(find.text('Start'), findsOneWidget);
  expect(find.text('Replay'), findsOneWidget);
  expect(find.byIcon(Icons.wifi_protected_setup), findsOneWidget);
  expect(find.text('Check'), findsOneWidget);
  expect(find.text('Mathematical Operation: '), findsOneWidget);
}
