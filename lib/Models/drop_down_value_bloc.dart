import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_apps/Data/drop_down_event.dart';

class DropDownValueBloc {
  DropDownList dropDownListObject = DropDownList();
  final _dropDownValueEventController = StreamController<String>.broadcast();
  StreamSink<String> get _inDropDownValue => _dropDownValueEventController
      .sink; //to create an output sink to get values from into stream

  Stream<String> get dropDownValue =>
      _dropDownValueEventController.stream; //to create stream of output

  final _dropDownValueStateController = StreamController<String>();

  Sink<String> get dropDownValueStreamController =>
      _dropDownValueStateController
          .sink; //to create sink of input for the variable

  List<DropdownMenuItem<String>> mappingToList() {
    return dropDownListObject.dropDownList.map((e) {
      return DropdownMenuItem<String>(
        value: e.toString(),
        child: Text(e.toString()),
      );
    }).toList();
  } //This is a function to provide the list of items in the dropdownlist ui

  DropDownValueBloc() {
    _dropDownValueStateController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(String selectedValueFromDropDown) {
    _inDropDownValue.add(selectedValueFromDropDown);
  }

  void dispose() {
    _dropDownValueEventController.close();
    _dropDownValueStateController.close();
  }
}
