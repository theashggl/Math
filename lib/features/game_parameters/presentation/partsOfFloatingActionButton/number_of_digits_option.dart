import 'package:flutter/material.dart';
import 'package:flutter_apps/shared/widgets/home_page_inherited_widget.dart';

class NumberOfDigitsOption extends StatefulWidget {
  const NumberOfDigitsOption({super.key});

  @override
  State<NumberOfDigitsOption> createState() => _NumberOfDigitsOptionState();
}

class _NumberOfDigitsOptionState extends State<NumberOfDigitsOption> {
  @override
  Widget build(BuildContext context) {
    final HomePageInheritedWidget inheritedProvider=HomePageInheritedWidget.of(context);
    print('Drop down index: ${inheritedProvider.gameObject.dropDownIndex}');
    print(
        'drop down built with value: ${inheritedProvider.gameObject.dropDownList[inheritedProvider.gameObject.dropDownIndex]}');
    return ListenableBuilder(
      listenable: inheritedProvider.gameObject,
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
                  inheritedProvider.gameObject.dropDownPressed(newValue: newValue);
                }
              },
                items: inheritedProvider.gameObject.mappingToList(),
                value: inheritedProvider.gameObject
                    .dropDownList[inheritedProvider.gameObject.dropDownIndex],
              ),
            ),
          ],
        );
      }
    );
  }
}
