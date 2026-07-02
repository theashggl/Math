import 'package:flutter/material.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/widgets/home_page_inherited_widget.dart';

class OperationSelectionOption extends StatefulWidget {
  final void Function(SelectedOperation) functionToPassIndexToParentWidget;
  const OperationSelectionOption(
      {super.key, required this.functionToPassIndexToParentWidget});

  @override
  State<OperationSelectionOption> createState() =>
      _OperationSelectionOptionState();
}

//Todo make the sizes dynamic in this class
class _OperationSelectionOptionState extends State<OperationSelectionOption> {
  @override
  Widget build(BuildContext context) {
    final HomePageInheritedWidget inheritedProvider = HomePageInheritedWidget.of(context);
    print('operation: ${inheritedProvider.gameObject.selectedOperation}');
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
                isSelected: inheritedProvider.gameObject.toggleButtonSelection,
                onPressed: (int indexOfSelected) {
                  inheritedProvider.gameObject.toggleButtonSelection[inheritedProvider.gameObject.selectedOperation.index] = false;
                  setState(() {
                    inheritedProvider.gameObject.toggleButtonSelection[indexOfSelected] = true;
                  });
                  inheritedProvider.gameObject.selectedOperation = SelectedOperation.values[indexOfSelected];
                  widget.functionToPassIndexToParentWidget(inheritedProvider.gameObject.selectedOperation);
                  print('check for division selection ${inheritedProvider.gameObject.selectedOperation}');
                },
                children: [
                  for (int i = 0; i < 4; i++)
                    Text(
                      inheritedProvider.gameObject.textsInOutlinedButton[i],
                      style: const TextStyle(fontSize: 50),
                    ),
                ]),
          ],
        )
      ],
    );
  }
}
