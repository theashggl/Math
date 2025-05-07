import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apps/Data/counter_event.dart';
import 'package:flutter_apps/Models/counter_bloc.dart';
import 'package:flutter_apps/Models/drop_down_value_bloc.dart';
import 'package:flutter_apps/Models/home_page_functionality.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'गणितज्ञ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? title;
  const MyHomePage({super.key, this.title});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late MyHomePageStateFunctionality homePageModel;
  late DropDownValueBloc dropDownValueBloc;
  late CounterBloc counterBloc;
  bool initializer = false;
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  bool _textFieldEnabled = false;
  MyHomePageState() {
    counterBloc = CounterBloc();
    homePageModel = MyHomePageStateFunctionality();
    dropDownValueBloc = DropDownValueBloc();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: StreamBuilder(
          stream: dropDownValueBloc.dropDownValue,
          initialData: '1',
          builder: (
            BuildContext dropDownContext,
            AsyncSnapshot<String?> dropDownSnapshot,
          ) {
            return StreamBuilder(
              stream: counterBloc.counter,
              initialData: 1,
              builder: (
                BuildContext counterContext,
                AsyncSnapshot<int> counterSnapshot,
              ) {
                homePageModel.submitGameState(
                  counterSnapshot,
                  dropDownSnapshot,
                );
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Digits: '),
                        Text(dropDownSnapshot.data!),
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
                        foregroundColor: Colors.teal,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        homePageModel
                            .navigateToNumberDisplay(context)
                            .then((value) {
                          setState(() {
                            _textFieldEnabled = value;
                          });
                          print('inside navigated future $_textFieldEnabled');
                        });
                      },
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Form(
                        key: _globalFormKey,
                        child: TextFormField(
                          enabled: _textFieldEnabled,
                          controller: _textEditingController,
                          decoration: const InputDecoration(
                            labelText: 'Enter your number',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              Icons.text_fields_rounded,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ], // Only numbers can be entered
                          validator: (String? value) {
                            print('text ${_textEditingController.text}');
                            return homePageModel.validatorOfTextFormField(
                              value: value,
                              isTextFieldEnabled: _textFieldEnabled,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          key: const Key('Replay'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.teal,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          onPressed: () {
                            homePageModel.navigateToNumberDisplay(context);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.wifi_protected_setup),
                              Text(
                                'Replay',
                                style: TextStyle(
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          onPressed: () {
                            if (!_textFieldEnabled) {
                              print('Disabled Button');
                              return;
                            } else if (!_globalFormKey.currentState!
                                .validate()) {
                              print('test$_textEditingController');
                              return;
                            } else {
                              showDialog<void>(
                                context: dropDownContext,
                                // barrierDismissible: barrierDismissible, false = user must tap button, true = tap outside dialog
                                builder: (BuildContext dialogContext) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  return AlertDialog(
                                    title: Text(
                                      homePageModel.rightOrWrong(
                                        _textEditingController.text,
                                      ),
                                    ),
                                    content: Text(
                                      homePageModel.resultText(
                                        homePageModel.rightOrWrong(
                                          _textEditingController.text,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) {});
                            }
                          },
                          child: const Text('Check'),
                        ),
                      ],
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
        onPressed: () {
          setState(() {
            _textFieldEnabled = false;
            _textEditingController.clear();
          });
           showDialog(
            context: context,
            builder: (BuildContext context) {
              return StreamBuilder(
                stream: dropDownValueBloc.dropDownValue,
                initialData: '1',
                builder: (
                  BuildContext dropDownContext,
                  AsyncSnapshot<String?> dropDownSnapshot,
                ) {
                  return StreamBuilder(
                    stream: counterBloc.counter,
                    initialData: 1,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  const Text('Number of Occurrences'),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: TextEditingController(
                                        text: counterSnapshot.data.toString(),
                                      ),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          splashRadius: 20.0,
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                          ),
                                          onPressed: () {
                                            counterBloc.counterEventSink
                                                .add(IncrementEvent());
                                            print(counterSnapshot.data);
                                          },
                                        ),
                                        prefixIcon: IconButton(
                                          splashRadius: 20.0,
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 100,
                              ),
                              Row(
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
                                  homePageModel.submitGameState(
                                    counterSnapshot,
                                    dropDownSnapshot,
                                  );
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
