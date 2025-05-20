import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

//This class will provide backend support to the number_display.dart file
class GameListGeneration {
  int answer = 0;
  final _streamController = StreamController<int>.broadcast();
  StreamSink<int> get _inputOfGameNumbers => _streamController.sink;
  Stream get outputStream => _streamController.stream;
  int? initialData;
  late final List _streamsProcessorList = List.filled(
    2,
    null,
  ); //list[0] contains input from _blocCounter.counter stream. list[1] contains input from _dropDownValueBloc.dropDownValue stream.

  GameListGeneration({required int? counter, required String? dropdown}) {
    _streamsProcessorList[0] = counter;
    _streamsProcessorList[1] = dropdown;
    arrayInitializer(_streamsProcessorList);
    print(_streamsProcessorList);
  }

  int? get initialDataGetter {
    return initialData;
  }

  void setInitialData(int? value) {
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
    const Duration duration = Duration(seconds: 2);
    for (int i = 0; i < int.parse(_streamsProcessorList[0].toString()); i++) {
      final num maxNumber = pow(
              10, int.parse(_streamsProcessorList[1].toString())) -
          1; //setting maximum number allowed by the input constraints of the user
      if (i == 0) {
        setInitialData(Random().nextInt(maxNumber.toInt()));
        print('initialDataGetter $initialDataGetter');
      } else {
        await Future.delayed(duration, () {
          final int temp = Random().nextInt(maxNumber.toInt());
          answer += temp;
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
