import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test Group', () {
    testWidgets('Test to setup the game', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final Finder floatingActionButton =
          find.byKey(const ValueKey('HomePageFloatingActionButton'));
      expect(floatingActionButton, findsOneWidget);
      await tester.tap(floatingActionButton);
      await tester.pumpAndSettle();
      final Finder floatingPopup =
          find.byKey(const ValueKey('CardForGameParameters'));
      expect(floatingPopup, findsOneWidget);
      final Finder counterIncreaser =
          find.byIcon(Icons.arrow_forward_ios_rounded);
      expect(find.text('0'), findsNWidgets(2));
      expect(find.text('Digits: '), findsOneWidget);
      for (int i = 0; i < 9; i++) {
        await tester.tap(counterIncreaser);
      }
      await tester.pumpAndSettle();
      expect(
        find.text('9'),
        findsNWidgets(
          2,
        ),
      ); //There are two instances because of the floating action button opening a popup and not a new screen, hence the previous screen is also visible to the tester object.
      Finder dropDown = find.byKey(const ValueKey('DropDownKey'));
      await tester.tap(dropDown);
      await tester.pumpAndSettle();
      expect(
        find.text('1'),
        findsNWidgets(
          3,
        ),
      ); //Counting the previous page usage of this value too hence this has three instances. Two from the dropdown stacks and one from the previous page default value.
      expect(
        find.text('2'),
        findsNWidgets(
          2,
        ),
      ); //The value is present twice in the stack of dropdownlist.
      expect(
        find.text('3'),
        findsNWidgets(
          2,
        ),
      ); //The value is present twice in the stack of dropdownlist.
      expect(
        find.text('4'),
        findsNWidgets(
          2,
        ),
      ); //The value is present twice in the stack of dropdownlist.
      dropDown = find
          .text('3')
          .last; //Selecting the last occurrence from the stack of dropdownlist to click.
      await tester.tap(dropDown);
      await tester.pumpAndSettle();
      expect(find.text('3'), findsNWidgets(2));
      expect(
        find.text('1'),
        findsOneWidget,
      ); //The list of data from dropdown will be present once anyhow but not twice as the dropdown has closed. Will be the same for the other values in 2 upcoming lines too.
      expect(find.text('2'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      final Finder submitButton =
          find.byKey(const ValueKey('SubmitGameParameters'));
      await tester.tap(submitButton);
      await tester.pumpAndSettle();
      expect(find.text('3'), findsOneWidget);
      expect(find.byKey(const ValueKey('StartGame')), findsOneWidget);
      expect(find.text('9'), findsOneWidget);
    });
  });
}
