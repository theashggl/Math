import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_parameters/presentation/partsOfFloatingActionButton/number_of_digits_option.dart';
import 'package:flutter_apps/features/game_parameters/presentation/partsOfFloatingActionButton/number_of_operands.dart';
import 'package:flutter_apps/features/game_parameters/presentation/partsOfFloatingActionButton/operation_selection_option.dart';
import 'package:flutter_apps/shared/widgets/home_page_inherited_widget.dart';

class GameParameterDialog extends StatefulWidget {
  const GameParameterDialog({super.key});

  @override
  State<GameParameterDialog> createState() => _GameParameterDialogState();
}

class _GameParameterDialogState extends State<GameParameterDialog> {
  @override
  Widget build(BuildContext context) {
    final HomePageInheritedWidget inheritedProvider =
        HomePageInheritedWidget.of(context);
    return FloatingActionButton(
      key: const ValueKey('HomePageFloatingActionButton'),
      onPressed: () {
        setState(() {
          inheritedProvider.gameObject.textFieldEnabled = false;
          inheritedProvider.gameObject.textEditingController.clear();
        });
        showDialog(
          context: context,
          builder: (BuildContext builderContext) {
            print(
                'checking for null: ${inheritedProvider.gameObject.dropDownIndex}');
            return Center(
              child: Card(
                key: const ValueKey('CardForGameParameters'),
                elevation: 20,
                shadowColor: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const NumberOfOccurrencesOption(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 100,
                    ),
                    OperationSelectionOption(
                      functionToPassIndexToParentWidget:
                          inheritedProvider.gameObject.setOptionSelectionIndex,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    const NumberOfDigitsOption(),
                    ElevatedButton(
                      key: const ValueKey('SubmitGameParameters'),
                      style: const ButtonStyle(
                        animationDuration: Duration(milliseconds: 20),
                      ),
                      child: const Text('Submit'),
                      onPressed: () {
                        // inheritedProvider.gameObject.submitGameState(
                        //   counterSnapshot,
                        // );
                        print(
                            'The enum is ${inheritedProvider.gameObject.selectedOperation}');
                        print('Mounted or not: ${context.mounted}');
                        Navigator.of(builderContext).pop();
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(builderContext).pop();
                          Future.delayed(const Duration(seconds: 5),(){
                          print('Mounted or not after delay: ${builderContext.mounted}');
        // debugDumpApp();
                          });
                          print('Mounted or not: ${builderContext.mounted}');
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.blue)),
                        child: const Text('Exit',)),
                  ],
                ),
              ),
            );
          },
        ).then((onValue) {
          print('context mount in then: ${context.mounted}');
              // debugDumpApp();
              print('mount in then check');
        });
        print('Check for route popped');
      },
      tooltip: 'Settings',
      child: const Icon(
        Icons.add,
      ),
    );
  }

}
