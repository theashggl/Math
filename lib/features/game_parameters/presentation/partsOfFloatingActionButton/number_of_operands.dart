import 'package:flutter/material.dart';
import 'package:flutter_apps/shared/entities/counter_event.dart';
import 'package:flutter_apps/shared/widgets/home_page_inherited_widget.dart';

class NumberOfOccurrencesOption extends StatefulWidget {
  const NumberOfOccurrencesOption({
    super.key,
  });

  @override
  State<NumberOfOccurrencesOption> createState() =>
      _NumberOfOccurrencesOptionState();
}

class _NumberOfOccurrencesOptionState extends State<NumberOfOccurrencesOption> {
  @override
  Widget build(BuildContext context) {
    final HomePageInheritedWidget inheritedProvider =
        HomePageInheritedWidget.of(context);
    return ListenableBuilder(
      listenable: inheritedProvider.gameObject,
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
                      inheritedProvider.gameObject
                          .operandCountChange(DecrementEvent());
                    },
                  ),
                  suffixIcon: IconButton(
                    splashRadius: 20.0,
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                    onPressed: () {
                      inheritedProvider.gameObject
                          .operandCountChange(IncrementEvent());
                      print(inheritedProvider.gameObject.operandCount);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                controller: TextEditingController(
                  text: inheritedProvider.gameObject.operandCount.toString(),
                ),
                textAlign: TextAlign.center,
                onChanged: (newValue) {
                  inheritedProvider.gameObject
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
