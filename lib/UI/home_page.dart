import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/Data/counter_event.dart';
import 'package:flutter_apps/Models/counter_bloc.dart';
import 'package:flutter_apps/Models/drop_down_value_bloc.dart';
import 'package:flutter_apps/Models/home_page_functionality.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

Random random = Random();

class MyHomePageState extends State<MyHomePage> {
  MyHomePageStateFunctionality homePageModel = MyHomePageStateFunctionality();
  DropDownValueBloc dropDownValueBloc = DropDownValueBloc();
  CounterBloc counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
          stream: dropDownValueBloc.dropDownValue,
          initialData: '1',
          builder: (
            BuildContext dropDownContext,
            AsyncSnapshot<String> dropDownSnapshot,
          ) {
            return StreamBuilder(
              stream: counterBloc.counter,
              initialData: 0,
              builder: (
                BuildContext counterContext,
                AsyncSnapshot<int> counterSnapshot,
              ) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Digits: '),
                        Text(dropDownSnapshot.data),
                        const Text('Numbers: '),
                        Text(counterSnapshot.data.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                      key: const Key('StartGame'),
                      style: TextButton.styleFrom(
                        primary: Colors.teal,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        print("To be implemented"); //todo
                        // int randomNumber;
                        // = random.nextInt(100);
                        // if (dropdownValue == 1.toString()) {
                        //   randomNumber = random.nextInt(9);
                        // } else if (dropdownValue == 2.toString()) {
                        //   randomNumber = random.nextInt(99);
                        // } else if (dropdownValue == 3.toString()) {
                        //   randomNumber = random.nextInt(999);
                        // } else {
                        //   randomNumber = random.nextInt(9999);
                        // }
                        homePageModel.listGeneration(
                          int.parse(dropDownSnapshot.data),
                          counterSnapshot.data,
                        );
                      },
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton.icon(
                      icon: const Icon(Icons.wifi_protected_setup),
                      label: const Text('Replay'),
                      style: TextButton.styleFrom(
                        primary: Colors.teal,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        print("To be implemented"); //todo
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        showDialog<void>(
                          context: dropDownContext,
                          // barrierDismissible: barrierDismissible, false = user must tap button, true = tap outside dialog
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: Text(homePageModel.rightOrWrong(54)),
                              content: Text(
                                'The correct answer is : ${homePageModel.getAnswer}',
                              ),
                              actions: <Widget>[
                                TextButton(
                                  style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                      (states) => Colors.blue.shade500,
                                    ),
                                  ),
                                  child: const Text(
                                    'Try Again',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(dialogContext)
                                        .pop(); // Dismiss alert dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Check'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('HomePageFloatingActionButton'),
        onPressed: () async {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return StreamBuilder(
                stream: dropDownValueBloc.dropDownValue,
                initialData: '1',
                builder: (
                  BuildContext dropDownContext,
                  AsyncSnapshot<String> dropDownSnapshot,
                ) {
                  return StreamBuilder(
                    stream: counterBloc.counter,
                    initialData: 0,
                    builder: (
                      BuildContext counterContext,
                      AsyncSnapshot<int> counterSnapshot,
                    ) {
                      return Center(
                        child: Card(
                          key: const ValueKey('CardForGameParameters'),
                          elevation: 20,
                          shadowColor: Colors.yellow,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text('Number of Inputs '),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: TextEditingController(
                                        text: counterSnapshot.data.toString(),
                                      ),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        labelText:
                                            'Enter the number of occurrences',
                                        suffixIcon: IconButton(
                                          splashRadius: 20.0,
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                          ),
                                          onPressed: () {
                                            counterBloc.counterEventSink
                                                .add(IncrementEvent());
                                          },
                                        ),
                                        prefixIcon: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_back_ios_rounded,
                                          ),
                                          onPressed: () {
                                            counterBloc.counterEventSink
                                                .add(DecrementEvent());
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                      ),
                                      onChanged: (newValue) {
                                        counterBloc.counterEventSink.add(
                                          RandomEvent(int.parse(newValue)),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('ABC'),
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
                                      onChanged: (newValue) {
                                        dropDownValueBloc
                                            .dropDownValueStreamController
                                            .add(newValue);
                                        // print(
                                        //     dropDownValueBloc.mappingToList());
                                      },
                                      items: dropDownValueBloc.mappingToList(),
                                      value: dropDownSnapshot.data,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                key: const ValueKey('SubmitGameParameters'),
                                style: const ButtonStyle(
                                  animationDuration: Duration(milliseconds: 20),
                                ),
                                child: const Text('Submit'),
                                onPressed: () {
                                  //TODO IMPLEMENTATION OF function for list of numbers for the game generation
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
        tooltip: 'Settings',
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
