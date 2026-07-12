import 'package:flutter/material.dart';
import 'package:flutter_apps/service_locator.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/game_parameters.dart';

class OperationSelectionOption extends StatefulWidget {
  final void Function(SelectedOperation) functionToPassIndexToParentWidget;
  GameLogic gameLogic;
  OperationSelectionOption(
      {super.key, required this.functionToPassIndexToParentWidget,required this.gameLogic});

  @override
  State<OperationSelectionOption> createState() =>
      _OperationSelectionOptionState();
}

//Todo make the sizes dynamic in this class
class _OperationSelectionOptionState extends State<OperationSelectionOption> {
  @override
  Widget build(BuildContext context) {
    // final HomePageInheritedWidget inheritedProvider = HomePageInheritedWidget.of(context);
    print('operation: ${getIt<GameParameters>().selectedOperation} hash of gamelogic: ${widget.gameLogic.hashCode}');
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
                isSelected: widget.gameLogic.toggleButtonSelection,
                onPressed: (int indexOfSelected) {
                  widget.gameLogic.toggleButtonSelection[getIt<GameParameters>().selectedOperation.index] = false;
                  setState(() {
                    widget.gameLogic.toggleButtonSelection[indexOfSelected] = true;
                  });
                  getIt<GameParameters>().selectedOperation = SelectedOperation.values[indexOfSelected];
                  widget.functionToPassIndexToParentWidget(getIt<GameParameters>().selectedOperation);
                  print('check for division selection ${getIt<GameParameters>().selectedOperation}');
                },
                children: [
                  for (int i = 0; i < 4; i++)
                    Text(
                      widget.gameLogic.textsInOutlinedButton[i],
                      style: const TextStyle(fontSize: 50),
                    ),
                ]),
          ],
        )
      ],
    );
  }
}
