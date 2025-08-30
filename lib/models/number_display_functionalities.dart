import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_apps/UI/partsOfFloatingActionButton/operation_selection_option.dart';

//This class will provide backend support to the number_display.dart file
class GameListGeneration {
  num answer = 0;
  num? initialData;
  final _streamController = StreamController<num>.broadcast();
  late SelectedOperation selectedOperation;
  StreamSink<num> get _inputOfGameNumbers => _streamController.sink;
  Stream get outputStream => _streamController.stream;
  late final List _streamsProcessorList = List.filled(
    2,
    null,
  ); //list[0] contains input from _blocCounter.counter stream. list[1] contains input from _dropDownValueBloc.dropDownValue stream.

  GameListGeneration(
      {required int? counter,
      required String? dropdown,
      required SelectedOperation selectedOperationEnum}) {
    _streamsProcessorList[0] = counter;
    _streamsProcessorList[1] = dropdown;
    selectedOperation = selectedOperationEnum;
    arrayInitializer(_streamsProcessorList);
  }

  num? get initialDataGetter {
    return initialData;
  }

  void setInitialData(num? value) {
    initialData = value;
    answer += value!;
  }

  void disposeStream() {
    print('disposed');
    _streamController.close();
  }

  void elevatedButtonPress(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done ||
        snapshot.connectionState == ConnectionState.waiting) {
      print(snapshot.connectionState);
      Navigator.pop(context, answer);
    }
  }

  Future<void> arrayInitializer(List ar) async {
    const Duration duration =
        Duration(seconds: 1); //Todo change it back to 2 seconds
    num temp;
    num Function(num, num) decidingOperation;
    final num maxNumber = pow(
            10, int.parse(_streamsProcessorList[1].toString())) -
        1; //setting maximum number allowed by the input constraints of the user;
    switch (selectedOperation) {
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
              operand2 = Random().nextInt(maxNumber.toInt());
            }
            temp = operand2;
            print('after change \n operand1: $operand1 operand2: $operand2');
            return operand1 /= operand2;
          };
        }
    }

    for (int i = 0; i < int.parse(_streamsProcessorList[0].toString()); i++) {
      if (i == 0) {
        setInitialData(Random().nextInt(maxNumber.toInt()));
        print('initialDataGetter $initialDataGetter');
      } else {
        await Future.delayed(duration, () {
          temp = Random().nextInt(maxNumber.toInt());
          answer = decidingOperation(answer, temp);
          print('$temp $answer');
          _inputOfGameNumbers.add(temp);
          if (i == int.parse(_streamsProcessorList[0].toString()) - 1) {
            disposeStream();
          }
        });
      }
    }
  }
}
