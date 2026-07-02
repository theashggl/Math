import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_numbers/domain/use_cases/number_display_functionalities.dart';
import 'package:flutter_apps/shared/entities/counter_event.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGameListGeneration extends Mock implements GameListGeneration {}

class MockDIVariables extends Mock implements DIVariables {}

class MockRandom extends Mock implements Random {}

void main() {
  group('game_information_logic.dart file test', () {
    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });
    final GameLogic gameLogic = GameLogic();
    test('operandCountChange method test', () {
      gameLogic.operandCountChange(IncrementEvent());
      expect(gameLogic.operandCount, 3);
      gameLogic.operandCountChange(DecrementEvent());
      expect(gameLogic.operandCount, 2);
      gameLogic.operandCountChange(RandomEvent(0));
      expect(gameLogic.operandCount, 2);
      gameLogic.operandCountChange(RandomEvent(11));
      expect(gameLogic.operandCount, 2);
      gameLogic.operandCountChange(DecrementEvent());
      expect(gameLogic.operandCount, 2);
      for (int i = 0; i < 20; i++) {
        gameLogic.operandCountChange(IncrementEvent());
      }
      expect(gameLogic.operandCount, 10);
    });
    test('setOptionSelectionIndex method test', () {
      gameLogic.setOptionSelectionIndex(SelectedOperation.plus);
      expect(gameLogic.operationTextInHomePage, '+ (addition)');
      gameLogic.setOptionSelectionIndex(SelectedOperation.multiply);
      expect(gameLogic.operationTextInHomePage, 'X (Multiplication)');
      gameLogic.setOptionSelectionIndex(SelectedOperation.minus);
      expect(gameLogic.operationTextInHomePage, '- (subtraction)');
      gameLogic.setOptionSelectionIndex(SelectedOperation.divide);
      expect(gameLogic.operationTextInHomePage, '÷ (division)');
    });
    test('dropDownPressed method test', () {
      gameLogic.dropDownPressed(newValue: '0');
      expect(gameLogic.dropDownIndex, 0);
      gameLogic.dropDownPressed(newValue: '1');
      expect(gameLogic.dropDownIndex, 0);
      gameLogic.dropDownPressed(newValue: '2');
      expect(gameLogic.dropDownIndex, 1);
      gameLogic.dropDownPressed(newValue: '3');
      expect(gameLogic.dropDownIndex, 2);
      gameLogic.dropDownPressed(newValue: '4');
      expect(gameLogic.dropDownIndex, 3);
    });
    test('mappingToList method test', () {
      expect(gameLogic.dropDownList, ['1', '2', '3', '4']);
      final tempList = gameLogic.mappingToList();
      expect(tempList.length, 4);
      for (int i = 0; i < gameLogic.dropDownList.length; i++) {
        expect(tempList[i], isA<DropdownMenuItem<String>>());
        expect(tempList[i].value, gameLogic.dropDownList[i]);
        expect((tempList[i].child as Text).data, gameLogic.dropDownList[i]);
      }
    });
    test('test method test', () {
      gameLogic.answer = 99;
      expect(gameLogic.rightOrWrong(userCalculation: '99'), "Right!!!");
      expect(gameLogic.rightOrWrong(userCalculation: '33'), "Wrong");
    });
    test('resultText method test', () {
      expect(gameLogic.resultText(result: 'Right!!!'), 'Correct answer!!!');
      expect(gameLogic.resultText(result: 'Wrong'),
          'Wrong answer! The correct answer is ${gameLogic.answer}');
    });
    test('validatorOfTextFormField method test', () {
      expect(
          gameLogic.validatorOfTextFormField(), 'Please start the game first');
      gameLogic.textFieldEnabled = true;
      expect(gameLogic.validatorOfTextFormField(), 'Please provide your input');
    });
    test('navigateToNumberDisplay method test', () async {
      var tempBool = gameLogic.navigateToNumberDisplay(() => Future.value(0.0));
      expect(gameLogic.textFieldEnabled, false);
      await tempBool;
      expect(gameLogic.textEditingController.text, '');
      expect(gameLogic.textFieldEnabled, true);
      expect(gameLogic.answer, 0.0);
      expect(await tempBool, true);
    });
  });
  group('number_display_functionalities.dart file test', () {
    late final MockDIVariables mockDIVariables;
    late final MockGameListGeneration mockGameListGeneration;
    final mockRandom = MockRandom();
    late final GameListGeneration gameListGeneration;
    mockDIVariables = MockDIVariables();
    mockGameListGeneration = MockGameListGeneration();

    when(() => mockRandom.nextInt(99)).thenReturn(30);
    // when(() => mockGameListGeneration.testableRandomInt(99))
    //     .thenReturn(40); //pass 2 to set maximum 10^2-1
    // // test('setInitialData method test', () {
    // //   gameListGeneration.setInitialData(2);
    // //   expect(gameListGeneration.initialData, 2);
    // // });
    // // test('initialDataGetter method test', () {
    // //   expect(gameListGeneration.initialDataGetter, 2);
    // // });

    when(() => mockDIVariables.selectedOperation)
        .thenReturn(SelectedOperation.plus);
    when(() => mockDIVariables.streamsProcessorList).thenReturn([2, 2]);
    gameListGeneration = GameListGeneration.testable(
      diVariablesParameter: mockDIVariables,
    );
    // print(
    //     '${mockDIVariables.streamsProcessorList} list ${mockDIVariables.streamsProcessorList[0]} ${mockDIVariables.streamsProcessorList[1]}');
    // when(() => gameListGeneration.testableRandomInt(6))
    //     .thenReturn(5);

    test('disposeStream method test', () {
      gameListGeneration.disposeStream();
      expect(gameListGeneration.diVariables.streamController.isClosed, true);
    });
    test('elevatedButtonPress method test', () {
      bool tempTest = false;
      const AsyncSnapshot asyncSnapshot = AsyncSnapshot.waiting();
      gameListGeneration.elevatedButtonPress(
          () => tempTest = true, asyncSnapshot);
      expect(tempTest, true);
    });
    test('arrayInitializer method test', () async {
      // print('${mockDIVariables.streamsProcessorList} operation');
      // when(() => gameListGeneration.testableRandomInt(99))
      //     .thenReturn(88);
      // .thenAnswer(mockGameListGeneration.testableRandomInt(99));
      await gameListGeneration.arrayInitializer(diVariables: mockDIVariables);
      // print('${mockDIVariables.streamsProcessorList} operation 2');
      // verify(() async => await mockGameListGeneration.gameStreamNumbers(
      //     99,
      //     const Duration(seconds: 1),
      //     (op1, op2) => op1 += op2,
      //     mockDIVariables.streamsProcessorList
      // )).called(1);
      expect(gameListGeneration.answer, 80);
    });
    // test('arrayInitializer method test', () {
    //   // when(() => gameListGeneration.testableRandomInt(99))
    //   //     .thenReturn(88);
    //   // .thenAnswer(mockGameListGeneration.testableRandomInt(99));
    //   backend.arrayInitializer(diVariables: mockDIVariables);
    //     verify(() => backend.streamNumbers(
    //         99, Duration.zero, (op1, op2) => op1 += op2,mockDIVariables.streamsProcessorList));
    //     expect(backend.answer, 80);
    //
    // });
  });
}
