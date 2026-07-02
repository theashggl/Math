import 'dart:async';
import 'dart:math';

class ListGeneration {
  final _streamController = StreamController<num>.broadcast();

  StreamSink<num> get _inputOfNumbers => _streamController.sink;
  num answer = 0;
  late final List streamsProcessorList = List.filled(
    2,
    null,
  );
  late final DIVariables diVariables;

  ListGeneration({
    required DIVariables diVariables,
  }) {
    this.diVariables = diVariables;
    arrayInitializer(diVariables: diVariables);
  }
  ListGeneration.test({required DIVariables diVariables}){
    this.diVariables=diVariables;
  }

  Future<void> arrayInitializer({required DIVariables diVariables}) async {
    const Duration duration =
        Duration(seconds: 1); //Todo change it back to 2 seconds
    num Function(num, num) operation;
    final num maxNumber = pow(
            10, num.parse(diVariables.streamsProcessorList[1].toString())) -
        1; //setting maximum number allowed by the input constraints of the user;
    print('maxNumber: $maxNumber');
    switch (diVariables.operation) {
      case OperationEnum.option1:
        {
          operation = (operand1, operand2) => operand1 += operand2;
          break;
        }
      case OperationEnum.option2:
        {
          operation = (operand1, operand2) => operand1 = 2 * operand2;
          break;
        }
      case OperationEnum.option3:
        {
          operation =
              (operand1, operand2) => operand1 = operand1 + 2 * operand2;
          break;
        }
      case OperationEnum.option4:
        {
          operation = (operand1, operand2) {
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
    await streamNumbers(maxNumber, duration, operation,diVariables.streamsProcessorList);
    print("check completion");
  }

  Future<void> streamNumbers(num maxNumber, Duration duration,
      num Function(num, num) decidingOperation,
      List streamsProcessorList) async {
    num temp;
    for (int i = 0; i < int.parse(streamsProcessorList[0].toString()); i++) {
      await Future.delayed(duration, () {
        print('object $streamsProcessorList');
        temp = testableRandomInt(maxNumber);
        answer = decidingOperation(answer, temp);
        print('temp: $temp answer: $answer');
        _inputOfNumbers.add(temp);
        if (i == int.parse(streamsProcessorList[0].toString()) - 1) {
          disposeStream();
        }
        return;
      });
    }
  }

  int testableRandomInt(num maxNumber) => Random().nextInt(maxNumber.toInt());

  void disposeStream() {
    print('disposed');
    _streamController.close();
  }
}

enum OperationEnum{option1,option2,option3,option4}
class DIVariables {
  late OperationEnum operation;
  late final List streamsProcessorList = List.filled(
    2,
    null,
  ); //list[0] contains input from _blocCounter.counter stream. list[1] contains input from _dropDownValueBloc.dropDownValue stream.
  DIVariables(
      {required OperationEnum operation,
      required int counter,
      required String digits}) {
    this.operation = operation;
    streamsProcessorList[0] = counter;
    streamsProcessorList[1] = int.parse(digits) + 1;
  }
}
