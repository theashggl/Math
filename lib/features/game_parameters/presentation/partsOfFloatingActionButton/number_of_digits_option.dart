import 'package:flutter/material.dart';
import 'package:flutter_apps/service_locator.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/game_parameters.dart';

class NumberOfDigitsOption extends StatefulWidget {
  GameLogic gameLogic;
  NumberOfDigitsOption({super.key,required this.gameLogic});

  @override
  State<NumberOfDigitsOption> createState() => _NumberOfDigitsOptionState();
}

class _NumberOfDigitsOptionState extends State<NumberOfDigitsOption> {
  @override
  Widget build(BuildContext context) {
    // final HomePageInheritedWidget inheritedProvider=HomePageInheritedWidget.of(context);
    print('Drop down index: ${getIt<GameParameters>().dropDownIndex}');
    print(
        'drop down built with value: ${widget.gameLogic.dropDownList[getIt<GameParameters>().dropDownIndex]}');
    return ListenableBuilder(
      listenable: widget.gameLogic,
      builder: (BuildContext context, Widget? child) {
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
                onChanged: (String? newValue) {
                if (newValue != null) {
                  widget.gameLogic.dropDownPressed(newValue: newValue);
                }
              },
                items: widget.gameLogic.mappingToList(),
                value: widget.gameLogic
                    .dropDownList[getIt<GameParameters>().dropDownIndex],
              ),
            ),
          ],
        );
      }
    );
  }
}
