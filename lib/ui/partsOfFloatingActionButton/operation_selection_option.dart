import 'package:flutter/material.dart';

class OperationSelectionOption extends StatefulWidget {
  final void Function(SelectedOperation) functionToPassIndexToParentWidget;
  const OperationSelectionOption(
      {super.key, required this.functionToPassIndexToParentWidget});

  @override
  State<OperationSelectionOption> createState() =>
      _OperationSelectionOptionState();
}

enum SelectedOperation { plus, minus, multiply, divide }

//Todo make the sizes dynamic in this class
class _OperationSelectionOptionState extends State<OperationSelectionOption> {
  SelectedOperation selectedOperation = SelectedOperation.plus;
  final List<String> textsInOutlinedButton = ["+", "-", "X", "÷"];
  final List<bool> _toggleButtonSelection = [true, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Select operation: ',
          style: TextStyle(fontSize: 20.0),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ToggleButtons(
                constraints:
                    const BoxConstraints(minHeight: 70.0, minWidth: 70.0),
                isSelected: _toggleButtonSelection,
                onPressed: (int indexOfSelected) {
                  _toggleButtonSelection[selectedOperation.index] = false;
                  setState(() {
                    _toggleButtonSelection[indexOfSelected] = true;
                  });
                  selectedOperation = SelectedOperation.values[indexOfSelected];
                  widget.functionToPassIndexToParentWidget(selectedOperation);
                  print('check for division selection $selectedOperation');
                },
                children: [
                  for (int i = 0; i < 4; i++)
                    Text(
                      textsInOutlinedButton[i],
                      style: const TextStyle(fontSize: 50),
                    ),
                ]),
          ],
        )
      ],
    );
  }
}
