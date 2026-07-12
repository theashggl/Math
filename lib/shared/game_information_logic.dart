import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_numbers/presentation/number_display.dart';
import 'package:flutter_apps/service_locator.dart';
import 'package:flutter_apps/shared/entities/counter_event.dart';
import 'package:flutter_apps/shared/game_parameters.dart';

enum SelectedOperation { plus, minus, multiply, divide }

class GameLogic extends ChangeNotifier {
  num? answer;
  bool textFieldEnabled = false;
  late String operationTextInHomePage = '+ (addition)';
  final List<String> _dropDownList = ['1', '2', '3', '4'];
  final List<String> textsInOutlinedButton = ["+", "-", "X", "÷"];
  final List<bool> toggleButtonSelection = [true, false, false, false];
  final TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  // SelectedOperation selectedOperation = SelectedOperation.plus;
  List<String> get dropDownList => _dropDownList;

  GameLogic([this.answer = 0]);

  void operandCountChange(CounterEvent eventType) {
    print('opearnd change');
    if (eventType is RandomEvent) {
      if (eventType.value > 0 && eventType.value <= 10) {
        // getIt<GameParameters>().operandCount = eventType.value;
        getIt<GameParameters>().notifyOperands(newValue: eventType.value);
      }
    } else if (eventType is IncrementEvent &&
        getIt<GameParameters>().operandCount < 10) {
      getIt<GameParameters>()
          .notifyOperands(newValue: ++getIt<GameParameters>().operandCount);
    } else {
      if (eventType is DecrementEvent &&
          getIt<GameParameters>().operandCount > 2 &&
          getIt<GameParameters>().operandCount <= 10) {
        getIt<GameParameters>()
            .notifyOperands(newValue: --getIt<GameParameters>().operandCount);
      }
    }
    notifyListeners();
  }

  void setOptionSelectionIndex(SelectedOperation enumValueOfSelectedOperation) {
    getIt<GameParameters>()
        .notifySelectedOperation(newValue: enumValueOfSelectedOperation);
    switch (getIt<GameParameters>().selectedOperation) {
      case SelectedOperation.plus:
        {
          this.operationTextInHomePage = '+ (addition)';
          break;
        }
      case SelectedOperation.minus:
        {
          this.operationTextInHomePage = '- (subtraction)';
          break;
        }
      case SelectedOperation.multiply:
        {
          this.operationTextInHomePage = 'X (Multiplication)';
          break;
        }
      case SelectedOperation.divide:
        {
          this.operationTextInHomePage = '÷ (division)';
          break;
        }
    }
    print('operation: $operationTextInHomePage');
    notifyListeners();
  }

  void dropDownPressed({required String newValue}) {
    if (newValue.codeUnitAt(0) >= 49 && newValue.codeUnitAt(0) <= 52) {
      getIt<GameParameters>()
          .notifyDropIndex(newValue: int.parse(newValue) - 1);
    }
    notifyListeners();
    print('Drop down index changed: $getIt<GameParameters>().dropDownIndex');
  }

  List<DropdownMenuItem<String>> mappingToList() {
    return dropDownList.map((element) {
      print('element is $element');
      return DropdownMenuItem(
        value: element,
        child: Text(element),
      );
    }).toList();
  }

//Methods containing the logic of the functionality checking the user input is right or wrong
//Todo Change the logic to a boolean returned from the method instead of the string
  String rightOrWrong({required String? userCalculation}) {
    if (num.parse(userCalculation!) == answer) {
      return "Right!!!";
    } else {
      return "Wrong";
    }
  }

//Method to give UI what to show based on the input given by the user is right or wrong
  String resultText({required String result}) {
    if (result == 'Right!!!') {
      return 'Correct answer!!!';
    } else {
      return 'Wrong answer! The correct answer is $answer';
    }
  }

//Errors to show in the textFormField in the home page
  String? validatorOfTextFormField({String? value}) {
    if (value == null || value.isEmpty) {
      if (textFieldEnabled) {
        return 'Please provide your input';
      } else {
        return 'Please start the game first';
      }
    }
    return null;
  }

  Future<bool> navigateToNumberDisplay(Future<num?> Function() navigate) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    textEditingController.clear();
    textFieldEnabled = false;
    notifyListeners();
    print('text: ${textEditingController.text}');
    answer = await navigate().then((onValue) {
      print('returning value from number display screen: $onValue');
      textFieldEnabled = true;
      return onValue;
    });
    notifyListeners();
    return true;
  }
}
