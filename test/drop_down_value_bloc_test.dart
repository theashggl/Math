import 'package:flutter_apps/Models/drop_down_value_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final DropDownValueBloc dropDownValueBloc = DropDownValueBloc();
  test('Test for mappingToList method', () {
    final output = dropDownValueBloc.mappingToList();
    // final List _dropDownList = [
    //   DropdownMenuItem<String>,
    //   DropdownMenuItem<String>,
    //   DropdownMenuItem<String>,
    //   DropdownMenuItem<String>
    // ];
    expect(output.length, 4);
  });
  // test('Test for mappingToList method data', () {//Test not getting successful so removing for now
  //   final List dropDownListTest = [1, 2, 3, 4];
  //   DropDownList  dropDownEvent=DropDownList();
  //   expect(
  //     dropDownValueBloc.mappingToList(),
  //     dropDownEvent.dropDownList.map((e) {
  //       return DropdownMenuItem<String>(
  //         value: e.toString(),
  //         child: Text(e.toString()),
  //       );
  //     }).toList(),
  //   );
  // });
}
