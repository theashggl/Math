import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_numbers/presentation/number_display.dart';
import 'package:flutter_apps/shared/entities/counter_event.dart';

enum SelectedOperation { plus, minus, multiply, divide }

//So far, since the logic is intertwined, this file will handle the logic for whole app unless needed otherwise.
class GameLogic extends ChangeNotifier {
  num? answer;
  int dropDownIndex = 0;
  int operandCount = 2;
  bool textFieldEnabled = false;
  late String operationTextInHomePage = '+ (addition)';
  final List<String> _dropDownList = ['1', '2', '3', '4'];
  final List<String> textsInOutlinedButton = ["+", "-", "X", "÷"];
  final List<bool> toggleButtonSelection = [true, false, false, false];
  final TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  SelectedOperation selectedOperation = SelectedOperation.plus;
  List<String> get dropDownList => _dropDownList;

  GameLogic([this.answer = 0]);

  void operandCountChange(CounterEvent eventType) {
    if (eventType is RandomEvent) {
      if (eventType.value > 0 && eventType.value <= 10) {
        operandCount = eventType.value;
      }
    } else if (eventType is IncrementEvent && operandCount < 10) {
      operandCount++;
    } else {
      if (eventType is DecrementEvent &&
          operandCount > 2 &&
          operandCount <= 10) {
        operandCount--;
      }
    }
    notifyListeners();
  }

  void setOptionSelectionIndex(SelectedOperation enumValueOfSelectedOperation) {
    selectedOperation = enumValueOfSelectedOperation;
    switch (selectedOperation) {
      case SelectedOperation.plus:
        {
          operationTextInHomePage = '+ (addition)';
          break;
        }
      case SelectedOperation.minus:
        {
          operationTextInHomePage = '- (subtraction)';
          break;
        }
      case SelectedOperation.multiply:
        {
          operationTextInHomePage = 'X (Multiplication)';
          break;
        }
      case SelectedOperation.divide:
        {
          operationTextInHomePage = '÷ (division)';
          break;
        }
    }
    notifyListeners();
  }

  void dropDownPressed({required String newValue}) {
    if(newValue.codeUnitAt(0)>=49&&newValue.codeUnitAt(0)<=52) {
      dropDownIndex = int.parse(newValue) - 1;
    }
    notifyListeners();
    print('Drop down index changed: $dropDownIndex');
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
  String? validatorOfTextFormField(
      {String? value}) {
    if (value == null || value.isEmpty) {
      if (textFieldEnabled) {
        return 'Please provide your input';
      } else {
        return 'Please start the game first';
      }
    }
    return null;
  }

  Future<bool> navigateToNumberDisplay(
      Future<num?> Function() navigate) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    textEditingController.clear();
    textFieldEnabled=false;
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