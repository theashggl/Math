import 'package:flutter/material.dart';
import 'package:flutter_apps/service_locator.dart';
import 'package:flutter_apps/shared/entities/counter_event.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/game_parameters.dart';

class NumberOfOccurrencesOption extends StatefulWidget {
  GameLogic gameLogic;
  NumberOfOccurrencesOption({
    super.key,
    required this.gameLogic
  });

  @override
  State<NumberOfOccurrencesOption> createState() =>
      _NumberOfOccurrencesOptionState();
}

class _NumberOfOccurrencesOptionState extends State<NumberOfOccurrencesOption> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.gameLogic,
      builder: (BuildContext context, Widget? child) {
        return Row(
          children: [
            const Text('Number of operands:'),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    splashRadius: 20.0,
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                    ),
                    onPressed: () {
                      widget.gameLogic
                          .operandCountChange(DecrementEvent());
                    },
                  ),
                  suffixIcon: IconButton(
                    splashRadius: 20.0,
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                    onPressed: () {
                      widget.gameLogic
                          .operandCountChange(IncrementEvent());
                      print('onpressed call changing it to: ${getIt<GameParameters>().operandCount}');
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                controller: TextEditingController(
                  text: getIt<GameParameters>().operandCount.toString(),
                ),
                textAlign: TextAlign.center,
                onChanged: (newValue) {
                  widget.gameLogic
                      .operandCountChange(RandomEvent(int.parse(newValue)));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
