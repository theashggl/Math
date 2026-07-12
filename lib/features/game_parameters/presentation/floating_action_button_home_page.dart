import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_parameters/presentation/partsOfFloatingActionButton/number_of_digits_option.dart';
import 'package:flutter_apps/features/game_parameters/presentation/partsOfFloatingActionButton/number_of_operands.dart';
import 'package:flutter_apps/features/game_parameters/presentation/partsOfFloatingActionButton/operation_selection_option.dart';
import 'package:flutter_apps/service_locator.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/game_parameters.dart';

class GameParameterDialog extends StatefulWidget {
  GameLogic gameLogic;
  GameParameterDialog({super.key,required this.gameLogic});

  @override
  State<GameParameterDialog> createState() => _GameParameterDialogState();
}

class _GameParameterDialogState extends State<GameParameterDialog> {
  @override
  Widget build(BuildContext context) {
    GameLogic gameLogic=GameLogic();
    // final HomePageInheritedWidget inheritedProvider =
    //     HomePageInheritedWidget.of(context);
    return FloatingActionButton(
      key: const ValueKey('HomePageFloatingActionButton'),
      onPressed: () {
        setState(() {
          gameLogic.textFieldEnabled = false;
          gameLogic.textEditingController.clear();
        });
        showDialog(
          context: context,
          builder: (BuildContext builderContext) {
            print(
                'checking for null: ${getIt<GameParameters>().dropDownIndex}');
            return Center(
              child: Card(
                key: const ValueKey('CardForGameParameters'),
                elevation: 20,
                shadowColor: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NumberOfOccurrencesOption(gameLogic: gameLogic,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 100,
                    ),
                    OperationSelectionOption(
                      functionToPassIndexToParentWidget:
                          gameLogic.setOptionSelectionIndex, gameLogic: widget.gameLogic,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    NumberOfDigitsOption(gameLogic: widget.gameLogic),
                    ElevatedButton(
                      key: const ValueKey('SubmitGameParameters'),
                      style: const ButtonStyle(
                        animationDuration: Duration(milliseconds: 20),
                      ),
                      child: const Text('Submit'),
                      onPressed: () {
                        // getIt<GameLogic>().submitGameState(
                        //   counterSnapshot,
                        // );
                        print(
                            'The enum is ${getIt<GameParameters>().selectedOperation}');
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
