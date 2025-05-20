import 'package:flutter/material.dart';
import 'package:flutter_apps/Data/inherited_widget_functionality.dart';
import 'package:flutter_apps/UI/number_display.dart';

//This class will provide all the backend functionalities to the home page of the app
class MyHomePageStateFunctionality {
  int? answer;

  late MyState stateAboveChildren;

  MyHomePageStateFunctionality() {
    answer = 0;
  }

  //Methods containing the logic of the functionality checking the user input is right or wrong
  String rightOrWrong(String? userCalculation) {
    if (int.parse(userCalculation!) == answer) {
      return "Right!!!";
    } else {
      return "Wrong";
    }
  }

  //Method to give UI what to show based on the input given by the user is right or wrong
  String resultText(String result) {
    if (result == 'Right!!!') {
      return 'Correct answer!!!';
    } else {
      return 'Wrong answer! The correct answer is $answer';
    }
  }

  //Errors to show in the textFormField in the home page
  String? validatorOfTextFormField(
      {String? value, required bool isTextFieldEnabled}) {
    if (value == null || value.isEmpty) {
      if (isTextFieldEnabled) {
        return 'Please provide your input';
      } else {
        return 'Please start the game first';
      }
    }
    return null;
  }

  void submitGameState(
    AsyncSnapshot<int> countersnapshot,
    AsyncSnapshot<String?> dropDownSnapshot,
  ) {
    stateAboveChildren = MyState(
      counter: countersnapshot.data,
      dropDownValue: dropDownSnapshot.data,
    );
  }

  Future<bool> navigateToNumberDisplay(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NumberDisplay(
          mystate: stateAboveChildren,
        ),
      ),
    );
    return true;
  }
}
