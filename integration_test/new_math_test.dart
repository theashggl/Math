import 'package:flutter/material.dart';
import 'package:flutter_apps/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

//Building the test file without any helper class for now. Todo change to Helper class implementation next
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test Group', () {
    testWidgets('Test to setup the game', (WidgetTester tester) async {
      //App is loaded
      app.main();
      await tester.pumpAndSettle();

      //Home screen test
      homeScreenTest(digits: '1', operands: '2', operation: '+ (addition)');

      //Game parameter screen test
      await gameParameterScreenTest(tester: tester);

      //Testing updated home screen after game parameters change
      homeScreenTest(digits: '3', operands: '9', operation: '÷ (division)');
      expect(find.text('Exit'), findsNothing);
      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();

      //Testing the number display screen
      numberDisplayTest();
    });
  });
}

//number displaying screen
void numberDisplayTest() {
  expect(find.byType(Text), findsNWidgets(2));
expect(  find.byWidgetPredicate((widget)=>widget is Text &&widget.data is String),findsNWidgets(2));
  expect(find.text('Exit'), findsOneWidget);
}

//home screen tests
void homeScreenTest(
    {required String digits,
    required String operands,
    required String operation}) {
  expect(find.text('Digits: '), findsOneWidget);
  expect(find.text(digits), findsOneWidget);
  expect(find.text('Count of operands: '), findsOneWidget);
  expect(find.text(operands), findsOneWidget);
  expect(find.text('Mathematical Operation: '), findsOneWidget);
  expect(find.text(operation), findsOneWidget);
  expect(find.byKey(const ValueKey('StartGame')), findsOneWidget);
  expect(find.bySubtype<ElevatedButton>(), findsNWidgets(2));
  expect(find.bySubtype<Form>(), findsOneWidget);
  expect(find.bySubtype<Row>(), findsNWidgets(3));
  expect(find.text('Check'), findsOneWidget);
  expect(find.text('Replay'), findsOneWidget);
}

//game parameter screen
Future<void> gameParameterScreenTest({required WidgetTester tester}) async {
  //Floating action button test
  final Finder floatingActionButton =
      find.byKey(const ValueKey('HomePageFloatingActionButton'));
  expect(floatingActionButton, findsOneWidget);

  //moving to game parameters screen
  await tester.tap(floatingActionButton);
  await tester.pumpAndSettle();
  expect(find.byKey(const ValueKey('CardForGameParameters')), findsOneWidget);
  expect(find.text('1'), findsNWidgets(2));
  expect(find.text('Digits: '), findsOneWidget);
  for (int i = 0; i < 8; i++) {
    await tester.tap(find.byIcon(Icons.arrow_forward_ios_rounded));
  }
  for (int i = 0; i < 1; i++) {
    await tester.tap(find.byIcon(Icons.arrow_back_ios_rounded));
  }
  await tester.pumpAndSettle();
  expect(
    find.text('9'),
    findsNWidgets(
      2,
    ),
  ); //There are two instances because of the floating action button opening a popup and not a new screen, hence the previous screen is also visible to the tester object.
  //operation selection test
  expect(find.text('+'), findsOneWidget);
  expect(find.text('-'), findsOneWidget);
  expect(find.text('X'), findsOneWidget);
  expect(find.text('÷'), findsOneWidget);
  expect(find.text('+ (addition)'), findsNWidgets(1));
  await tester.tap(find.text('-'));
  await tester.pumpAndSettle();
  expect(find.text('- (subtraction)'), findsNWidgets(1));
  await tester.tap(find.text('X'));
  await tester.pumpAndSettle();
  expect(find.text('X (Multiplication)'), findsNWidgets(1));
  await tester.tap(find.text('÷'));
  await tester.pumpAndSettle();
  expect(find.text('÷ (division)'), findsNWidgets(1));
  //Drop down test
  expect(find.text('1'), findsNWidgets(2));
  await tester.tap(find.byKey(const ValueKey('DropDownKey')));
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
  //Selecting the last occurrence from the stack of dropdownlist to click.
  await tester.tap(find.text('3').last);
  await tester.pumpAndSettle();
  expect(find.text('3'), findsNWidgets(2));
  expect(find.text('Exit'), findsOneWidget);
  await tester.tap(find.byKey(const ValueKey('SubmitGameParameters')));
  await tester.pumpAndSettle();
}
