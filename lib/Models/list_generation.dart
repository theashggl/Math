import 'dart:async';
import 'dart:math';
import 'package:async/async.dart';
import 'package:flutter_apps/Models/counter_bloc.dart';
import 'package:flutter_apps/Models/drop_down_value_bloc.dart';

// lengthValuesStream.listen((newLength) {
//
// Stream<int> lengthValuesStream = <something>;
//
// List<int?> theListThatWillBeUpdated = []; // Here i initially set it to be empty, you can change this if needed
class GameListGeneration {
  final CounterBloc _blocCounter = CounterBloc();
  final DropDownValueBloc _dropDownValueBloc = DropDownValueBloc();
  final _streamController = StreamController<int>.broadcast();
  StreamSink<int> get _inputOfGameNumbers => _streamController.sink;

  GameListGeneration() {
    print("oi");
  final Random _random = Random();
  // Stream  outputOfGameNumbers =
  // print(outputOfGameNumbers);
  createData().listen((eventOfStreamHavingLengthOfGameAndDigitCount) {
    num maxNumber = pow(num.parse(eventOfStreamHavingLengthOfGameAndDigitCount[0].toString()), num.parse(eventOfStreamHavingLengthOfGameAndDigitCount[1].toString())) - 1;
    print(123);
  });
    // _blocCounter.counter.listen((newLengthOfGame) {
    //   _dropDownValueBloc.dropDownValue.listen((event) {
    //     print("${newLengthOfGame}hwllo");
    //     _inputOfGameNumbers.add(_random.nextInt(maxNumber.toInt()));
    //   });
    // });
  }
  Stream createData() {
    return StreamZip([_blocCounter.counter,_dropDownValueBloc.dropDownValue]).asBroadcastStream();
  }
  // Future getList(){
  //   return createData().toList();
  // }
  // Future<int> arrayInitializer(Stream<int> arLengthStream,int numberOfDigits) async {
// await for (final int lngth in arLengthStream) {
  //    List<int> _dataArray =[];
  //   for (int i =0 ;i<lngth;i++) {
  //     final random = Random();
  //     await for (final int digit in numberOfDigits) {
  //       final num maxNumber = pow(10,digit)-1;
  //       print(maxNumber);
  //       print("        line break        ");
  //       print(_data_array[i]);
  //       _data_array[i]=random.nextInt(maxNumber.toInt());
  //       print(_data_array[i]);
  //       _inputOfGameNumbers.add(_data_array[i]);
  //     }
  //   }
  // }
  // arLengthStream.listen((newLength) {_dataArray=List.filled(newLength, null);});

// await for (int digit in arLengthStream) {

  // num maxNumber = pow(10,newLengthOfGame)-1;
  // }
  //  random.nextInt(maxNumber.toInt());
  // }
}
//
// theListThatWillBeUpdated = List.filled(newLength, null);
//
// // Either above, or this if you want to keep the same list reference
//
// theListThatWillBeUpdated.clear();
// theListThatWillBeUpdated.addAll(Iterable.generate(newLength, () => null));
// });
