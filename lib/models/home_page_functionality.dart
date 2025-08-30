import 'package:flutter/material.dart';
import 'package:flutter_apps/Data/inherited_widget_functionality.dart';
import 'package:flutter_apps/Models/counter_bloc.dart';
import 'package:flutter_apps/Models/drop_down_value_bloc.dart';
import 'package:flutter_apps/UI/number_display.dart';
import 'package:flutter_apps/UI/partsOfFloatingActionButton/operation_selection_option.dart';

//This class will provide all the backend functionalities to the home page of the app
class MyHomePageStateFunctionality {
  num? answer;
  MyState stateAboveChildren=const MyState(counter: 1, dropDownValue: '1');
  SelectedOperation selectedOperation = SelectedOperation.plus;
  late String operationTextInHomePage = '+ (addition)';
  bool textFieldEnabled = false;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  DropDownValueBloc dropDownValueBloc = DropDownValueBloc();
  CounterBloc counterBloc = CounterBloc();
  final TextEditingController textEditingController = TextEditingController();

  MyHomePageStateFunctionality() {
    answer = 0;
  }

  //Methods containing the logic of the functionality checking the user input is right or wrong
  //Todo Change the logic to a boolean returned from the method instead of the string
  String rightOrWrong(String? userCalculation) {
    if(num.parse(userCalculation!) == answer) {
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
    AsyncSnapshot<int> counterSnapshot,
    AsyncSnapshot<String?> dropDownSnapshot,
  ) {
    stateAboveChildren = MyState(
      counter: counterSnapshot.data,
      dropDownValue: dropDownSnapshot.data,
    );
  }

  Future<bool> navigateToNumberDisplay(BuildContext context, SelectedOperation selectedOperation) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    print('check for $selectedOperation');
    answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NumberDisplay(
          mystate: stateAboveChildren, selectedOperation: selectedOperation,
        ),
      ),
    );
    return true;
  }
}
