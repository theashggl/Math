import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
void main(){
DIVariables diVariables=DIVariables(selectedOperation: SelectedOperation.plus, counter: 2, digits: '2');
GameListGeneration? gameListGeneration;
gameListGeneration=GameListGeneration(gameListGenerationForDI: gameListGeneration, diVariables: diVariables);
gameListGeneration.arrayInitializer(diVariables: diVariables);
}
//This class will provide backend support to the number_display.dart file
class GameListGeneration {

  late final GameListGeneration gameListGeneration;
  late final DIVariables diVariables;
  num answer = 0;
  GameListGeneration(
      {required GameListGeneration? gameListGenerationForDI,
      required DIVariables diVariables}) {
    gameListGeneration = gameListGenerationForDI ?? this;
    this.diVariables = diVariables;
    arrayInitializer(diVariables: diVariables);
  }
  // num? get initialDataGetter {
  //   return initialData;
  // }

  // void setInitialData(num? value) {
  //   initialData = value;
  //   answer += value!;
  // }

  void elevatedButtonPress(void Function() toPop, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done ||
        snapshot.connectionState == ConnectionState.waiting) {
      print(snapshot.connectionState);
      toPop();
    }
  }

  final _streamController = StreamController<num>.broadcast();

  StreamController<num> get streamController => _streamController;

  StreamSink<num> get _inputOfGameNumbers => _streamController.sink;

  Stream<num> get outputStream => _streamController.stream;

  Future<void> gameStreamNumbers(
      num maxNumber,
      Duration duration,
      num Function(num, num) decidingOperation,
      List streamsProcessorList) async {
    num temp;
    for (int i = 0; i < int.parse(streamsProcessorList[0].toString()); i++) {
      await Future.delayed(duration, () {
        print('object $streamsProcessorList');
        temp = testableRandomInt(maxNumber);
        answer = decidingOperation(answer, temp);
        print('temp: $temp answer: $answer');
        _inputOfGameNumbers.add(temp);
        if (i == int.parse(streamsProcessorList[0].toString()) - 1) {
          disposeStream();
        }
        return;
      });
    }
  }

  int testableRandomInt(num maxNumber) => Random().nextInt(maxNumber.toInt());
  Future<void> arrayInitializer({required DIVariables diVariables}) async {
    const Duration duration =
        Duration(seconds: 1); //Todo change it back to 2 seconds
    num Function(num, num) decidingOperation;
    final num maxNumber = pow(
            10, num.parse(diVariables.streamsProcessorList[1].toString())) -
        1; //setting maximum number allowed by the input constraints of the user;
    print('maxNumber: $maxNumber');
    switch (diVariables.selectedOperation) {
      case SelectedOperation.plus:
        {
          decidingOperation = (operand1, operand2) => operand1 += operand2;
          break;
        }
      case SelectedOperation.minus:
        {
          decidingOperation = (operand1, operand2) => operand1 -= operand2;
          break;
        }
      case SelectedOperation.multiply:
        {
          decidingOperation = (operand1, operand2) => operand1 *= operand2;
          break;
        }
      case SelectedOperation.divide:
        {
          decidingOperation = (operand1, operand2) {
            print('operand1: $operand1 operand2: $operand2');
            while (operand2 == 0) {
              operand2 = testableRandomInt(maxNumber);
            }
            // temp = operand2;
            print('after change \n operand1: $operand1 operand2: $operand2');
            return operand1 /= operand2;
          };
        }
    }
    print("check completion");
    await gameStreamNumbers(maxNumber, duration, decidingOperation,
        diVariables.streamsProcessorList);
  }

  void disposeStream() {
    print('disposed');
    _streamController.close();
  }
}

class DIVariables {
  late SelectedOperation selectedOperation;
  late final List streamsProcessorList = List.filled(
    2,
    null,
  ); //list[0] contains input from _blocCounter.counter stream. list[1] contains input from _dropDownValueBloc.dropDownValue stream.
  DIVariables(
      {required SelectedOperation selectedOperation,
      required int counter,
      required String digits}) {
    this.selectedOperation = selectedOperation;
    streamsProcessorList[0] = counter;
    streamsProcessorList[1] = int.parse(digits) + 1;
  }
}
