import 'package:flutter/material.dart';
import 'package:flutter_apps/Data/counter_event.dart';
import 'package:flutter_apps/Models/counter_bloc.dart';

class NumberOfOccurencesOption extends StatefulWidget {
  final AsyncSnapshot counterSnapshot;
  final CounterBloc counterBloc;
  const NumberOfOccurencesOption({super.key, required this.counterSnapshot, required this.counterBloc});

  @override
  State<NumberOfOccurencesOption> createState() => _NumberOfOccurencesOptionState();
}

class _NumberOfOccurencesOptionState extends State<NumberOfOccurencesOption> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Number of Occurrences'),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: TextEditingController(
              text: widget.counterSnapshot.data.toString(),
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                splashRadius: 20.0,
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
                onPressed: () {
                  widget.counterBloc.counterEventSink
                      .add(IncrementEvent());
                  print(widget.counterSnapshot.data);
                },
              ),
              prefixIcon: IconButton(
                splashRadius: 20.0,
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                ),
                onPressed: () {
                  widget.counterBloc.counterEventSink
                      .add(DecrementEvent());
                },
              ),
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(50.0),
              ),
            ),
            onChanged: (newValue) {
              widget.counterBloc.counterEventSink.add(
                RandomEvent(int.parse(newValue)),
              );
            },
          ),
        ),
      ],
    );
  }

}
