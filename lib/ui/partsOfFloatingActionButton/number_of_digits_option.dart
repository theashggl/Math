import 'package:flutter/material.dart';
import 'package:flutter_apps/Models/drop_down_value_bloc.dart';

class NumberOfDigitsOption extends StatefulWidget {
  final DropDownValueBloc dropDownValueBloc;
  final AsyncSnapshot<String?> dropDownSnapshot;
  const NumberOfDigitsOption({super.key, required this.dropDownValueBloc, required this.dropDownSnapshot,});

  @override
  State<NumberOfDigitsOption> createState() => _NumberOfDigitsOptionState();
}

class _NumberOfDigitsOptionState extends State<NumberOfDigitsOption> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Number of digits: '),
        const SizedBox(
          width: 40,
        ),
        InkWell(
          splashColor: Colors.blue.withAlpha(30),
          child: DropdownButton<String>(
            key: const ValueKey('DropDownKey'),
            icon: const Icon(Icons.arrow_downward),
            iconSize: 19,
            elevation: 20,
            onChanged: (newValue) {
              widget.dropDownValueBloc
                  .dropDownValueStreamController
                  .add(newValue);
              // print(
              //     dropDownValueBloc.mappingToList());
            },
            items: widget.dropDownValueBloc.mappingToList(),
            value: widget.dropDownSnapshot.data,
          ),
        ),
      ],
    );
  }
}
