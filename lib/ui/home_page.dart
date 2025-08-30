import 'package:flutter/material.dart';
import 'package:flutter_apps/Models/home_page_functionality.dart';
import 'package:flutter_apps/UI/partsOfFloatingActionButton/number_of_digits_option.dart';
import 'package:flutter_apps/UI/partsOfFloatingActionButton/number_of_occurences_option.dart';
import 'package:flutter_apps/UI/partsOfFloatingActionButton/operation_selection_option.dart';
import 'package:flutter_apps/ui/partsOfHomePage/app_bar_of_scaffold.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key,required this.title});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late MyHomePageStateFunctionality homePageModel =
      MyHomePageStateFunctionality();

  void setOptionSelectionIndex(SelectedOperation enumValueOfSelectedOperation) {
    homePageModel.selectedOperation = enumValueOfSelectedOperation;
    switch (homePageModel.selectedOperation) {
      case SelectedOperation.plus:
        {
          setState(() {
            homePageModel.operationTextInHomePage = '+ (addition)';
          });
          break;
        }
      case SelectedOperation.minus:
        {
          setState(() {
            homePageModel.operationTextInHomePage = '- (subtraction)';
          });
          break;
        }
      case SelectedOperation.multiply:
        {
          setState(() {
            homePageModel.operationTextInHomePage = 'X (Multiplication)';
          });
          break;
        }
      case SelectedOperation.divide:
        {
          setState(() {
            homePageModel.operationTextInHomePage = '÷ (division)';
          });
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOfScaffold(title: widget.title),
      //Todo separate the UI elements into separate widgets handling the body and floating action button sections
      body: Center(
        child: StreamBuilder(
          stream: homePageModel.dropDownValueBloc.dropDownValue,
          initialData: '1',
          builder: (
            BuildContext dropDownContext,
            AsyncSnapshot<String?> dropDownSnapshot,
          ) {
            return StreamBuilder(
              stream: homePageModel.counterBloc.counter,
              initialData: 2,
              builder: (
                BuildContext counterContext,
                AsyncSnapshot<int> counterSnapshot,
              ) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Digits: '),
                          Text(
                            dropDownSnapshot.data!,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 40,
                            ),
                          ),
                          const Text('Count of operands: '),
                          Text(
                            counterSnapshot.data.toString(),
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 40),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      const Text('Mathematical Operation: '),
                      Text(homePageModel.operationTextInHomePage,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 40),
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
                              .navigateToNumberDisplay(
                                  context, homePageModel.selectedOperation)
                              .then((value) {
                            setState(() {
                              homePageModel.textFieldEnabled = value;
                            });
                            print(
                                'inside navigated future $homePageModel.textFieldEnabled');
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
                          key: homePageModel.globalFormKey,
                          child: TextFormField(
                            enabled: homePageModel.textFieldEnabled,
                            controller: homePageModel.textEditingController,
                            decoration: const InputDecoration(
                              labelText: 'Enter your number',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(
                                Icons.text_fields_rounded,
                              ),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.digitsOnly,
                            // ], // Only numbers can be entered
                            validator: (String? value) {
                              print(
                                  'text ${homePageModel.textEditingController.text}');
                              return homePageModel.validatorOfTextFormField(
                                value: value,
                                isTextFieldEnabled:
                                    homePageModel.textFieldEnabled,
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
                              homePageModel.navigateToNumberDisplay(
                                  context, homePageModel.selectedOperation);
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
                              if (!homePageModel.textFieldEnabled) {
                                print('Disabled Button');
                                return;
                              } else if (!homePageModel.globalFormKey.currentState!
                                  .validate()) {
                                print(
                                    'test${homePageModel.textEditingController}');
                                return;
                              } else {
                                showDialog<void>(
                                  context: dropDownContext,
                                  // barrierDismissible: barrierDismissible, false = user must tap button, true = tap outside dialog
                                  builder: (BuildContext dialogContext) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    return AlertDialog(
                                      title: Text(
                                        homePageModel.rightOrWrong(
                                          homePageModel
                                              .textEditingController.text,
                                        ),
                                      ),
                                      content: Text(
                                        homePageModel.resultText(
                                          homePageModel.rightOrWrong(
                                            homePageModel
                                                .textEditingController.text,
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
                  ),
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
            homePageModel.textFieldEnabled = false;
            homePageModel.textEditingController.clear();
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StreamBuilder(
                stream: homePageModel.dropDownValueBloc.dropDownValue,
                initialData: '1',
                builder: (
                  BuildContext dropDownContext,
                  AsyncSnapshot<String?> dropDownSnapshot,
                ) {
                  return StreamBuilder(
                    stream: homePageModel.counterBloc.counter,
                    initialData: 2,
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
                              NumberOfOccurencesOption(
                                  counterSnapshot: counterSnapshot,
                                  counterBloc: homePageModel.counterBloc),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 100,
                              ),
                              OperationSelectionOption(
                                functionToPassIndexToParentWidget:
                                    setOptionSelectionIndex,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 50,
                              ),
                              NumberOfDigitsOption(
                                  dropDownValueBloc: homePageModel.dropDownValueBloc,
                                  dropDownSnapshot: dropDownSnapshot),
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
                                  print(
                                      'The enum is $homePageModel.selectedOperation');
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.blue)),
                                  child: const Text('Exit')),
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
