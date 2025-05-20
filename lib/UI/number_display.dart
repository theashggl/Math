import 'package:flutter/material.dart';
import 'package:flutter_apps/Data/inherited_widget_functionality.dart';
import 'package:flutter_apps/Models/number_display_functionalities.dart';

//This page will show the numbers on the screen once the user hits start on the home page
class NumberDisplay extends StatelessWidget {
  final MyState mystate;
  const NumberDisplay({super.key, required this.mystate});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NumberScreen(
        counter: mystate.counter,
        dropDownValue: mystate.dropDownValue,
      ),
    );
  }
}

class NumberScreen extends StatefulWidget {
  final int? counter;
  final String? dropDownValue;
  const NumberScreen({
    required this.counter,
    required this.dropDownValue,
    super.key,
  });
  @override
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  late GameListGeneration gameListGeneration;

  @override
  void initState() {
    super.initState();
    print('object ${widget.counter}');
    gameListGeneration = GameListGeneration(
      counter: widget.counter,
      dropdown: widget.dropDownValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: gameListGeneration.outputStream,
        initialData: gameListGeneration.initialData,
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data.toString(),
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  child: const Text('Exit'),
                  onPressed: () {
                    print(snapshot.connectionState);
                    gameListGeneration.elevatedButtonPress(context, snapshot);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
