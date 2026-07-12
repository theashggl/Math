import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_apps/service_locator.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/game_parameters.dart';

///This class will provide backend support to the number_display.dart file
class GameListGeneration {
  // late final GameListGeneration gameListGeneration;
  late final DIVariables diVariables;
  num answer=0;

  GameListGeneration(
      {required this.diVariables}) {
    arrayInitializer(diVariables: diVariables);
    print('${getIt<GameParameters>().dropDownIndex} ${getIt<GameParameters>().operandCount} list');
  }
  GameListGeneration.testable({required DIVariables diVariablesParameter}){
    this.diVariables=diVariablesParameter;
  }
  // num? get initialDataGetter {
  //   return initialData;
  // }

  // void setInitialData(num? value) {
  //   initialData = value;
  //   answer += value!;
  // }

  void elevatedButtonPress(void Function() toPop, AsyncSnapshot snapshot) {
    if (
    // snapshot.connectionState == ConnectionState.done ||
    //     snapshot.connectionState == ConnectionState.waiting||
    diVariables.streamController.isClosed) {
      print(snapshot.connectionState);
      toPop();
    }
    print('state of connection: ${snapshot.connectionState}');
  }
  Future<void> gameStreamNumbers(
      num maxNumber,
      Duration duration,
      num Function(num, num) decidingOperation) async {
    num temp;
    for (int i = 0; i < int.parse(getIt<GameParameters>().operandCount.toString()); i++) {
        print('object [${getIt<GameParameters>().operandCount},${getIt<GameParameters>().dropDownIndex}]');
      await Future.delayed(duration, () {
        print('object [${getIt<GameParameters>().operandCount},${getIt<GameParameters>().dropDownIndex}] maxNumber: $maxNumber');
        print('check random: ${diVariables.testableRandomInt(99)} and: ${diVariables.testableRandomInt(maxNumber)}');
        temp = diVariables.testableRandomInt(maxNumber);
        if(i==0) {
          answer = temp;
        } else {
          answer = decidingOperation(answer, temp);
        }
        print('temp: $temp answer: $answer');
        diVariables.inputOfGameNumbers.add(temp);
        if (i == int.parse(getIt<GameParameters>().operandCount.toString()) - 1) {
          disposeStream();
        }
      });
    }
  }

  Future<void> arrayInitializer({required DIVariables diVariables}) async {
    const Duration duration =
        Duration(seconds: 1); //Todo change it back to 2 seconds
    num Function(num, num) decidingOperation;
        print('pow: ${num.parse((getIt<GameParameters>().dropDownIndex+1).toString())}');
    final num maxNumber = pow(
            10,
        num.parse(
            (getIt<GameParameters>().dropDownIndex+1).toString()
        )); //setting maximum number allowed by the input constraints of the user;
    print('maxNumber: $maxNumber ');
    switch (getIt<GameParameters>().selectedOperation) {
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
              operand2 = diVariables.testableRandomInt(maxNumber);
            }
            // temp = operand2;
            print('after change \n operand1: $operand1 operand2: $operand2');
            return operand1 /= operand2;
          };
        }
    }
    print("check completion");
    print('${decidingOperation(2,2)} max: $maxNumber parameters: [${getIt<GameParameters>().dropDownIndex},${getIt<GameParameters>().operandCount}]');
    await this.gameStreamNumbers(
        maxNumber,
        duration,
        decidingOperation);
  }
  void disposeStream() {
    print('disposed');
    diVariables.streamController.close();
  }
}

class DIVariables {
  late final List streamsProcessorList = List.filled(
    2,
    null,
  ); //list[0] contains input from _blocCounter.counter stream. list[1] contains input from _dropDownValueBloc.dropDownValue stream.
  final _streamController = StreamController<num>.broadcast();
  Stream<num> get outputStream => _streamController.stream;
  StreamSink<num> get inputOfGameNumbers => streamController.sink;

  StreamController<num> get streamController => _streamController;

  DIVariables(
      {required int counter,
      required String digits}) {
    streamsProcessorList[0] = counter;
    streamsProcessorList[1] = int.parse(digits) + 1;
  }
  int testableRandomInt(num maxNumber) => Random().nextInt(maxNumber.toInt());

}
