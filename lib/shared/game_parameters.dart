import 'package:flutter/cupertino.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';

class GameParameters extends ChangeNotifier{
  SelectedOperation selectedOperation = SelectedOperation.plus;
  int dropDownIndex = 0;
  int operandCount = 2;

  void notifySelectedOperation({required SelectedOperation newValue}){
    selectedOperation=newValue;
    notifyListeners();
  }
  void notifyDropIndex({required int newValue}){
    dropDownIndex=newValue;
    notifyListeners();
  }
  void notifyOperands({required int newValue}){
    operandCount=newValue;
    notifyListeners();
  }
}