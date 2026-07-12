import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_numbers/presentation/number_display.dart';
import 'package:flutter_apps/service_locator.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/game_parameters.dart';

class GameInformationBody extends StatefulWidget {
  GameLogic gameLogic;
  GameInformationBody({
    super.key,
    required this.gameLogic
  });

  @override
  State<GameInformationBody> createState() => _GameInformationBodyState();
}

class _GameInformationBodyState extends State<GameInformationBody> {
  // late final AppLifecycleListener listener;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   listener = AppLifecycleListener(
  //     onResume: () => debugDumpApp(),
  //     onShow: () {
  //       print('show home page executed');
  //       debugDumpApp();
  //     },
  //     onHide: () {
  //       print('onHide executed');
  //     },
  //     onInactive: () {
  //       print('onInactive executed');
  //     },
  //     onPause: () {
  //       print('onPause executed');
  //     },
  //     onDetach: () {
  //       print('onDetach executed');
  //     },
  //     onRestart: () {
  //       print('onRestart executed');
  //     },
  //     onStateChange: (AppLifecycleState state)=>print('state changed for home page executed'),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    // final HomePageInheritedWidget inheritedProvider =
    //     HomePageInheritedWidget.of(context);
    print(
        'inherited data: ${widget.gameLogic.operationTextInHomePage}');
    return Center(
        child: SingleChildScrollView(
      child: ListenableBuilder(
          listenable: getIt<GameParameters>(),
          builder: (BuildContext context, Widget? child) {
print('checking object between rebuilds: ${widget.gameLogic.hashCode}');
            print('GameParameters rebuilt with operation: ${widget.gameLogic.operationTextInHomePage}');
            return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Digits: '),
              Text(
                (getIt<GameParameters>().dropDownIndex + 1).toString(),
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                ),
              ),
              const Text('Count of operands: '),
              Text(
                getIt<GameParameters>().operandCount.toString(),
                style: const TextStyle(color: Colors.blue, fontSize: 40),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          const Text('Mathematical Operation: '),
          //Listening to the change in the operationTextInHomePage variable
          ListenableBuilder(
            listenable: widget.gameLogic,
            builder: (BuildContext context,Widget? child) {
              print('rebuild gamelogic ${widget.gameLogic.operationTextInHomePage}');
              return
                Text(
                widget.gameLogic.operationTextInHomePage,
                style: const TextStyle(color: Colors.blue, fontSize: 40),
              );
            }
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
              widget.gameLogic
                  .navigateToNumberDisplay(
                () async => await Navigator.push(
                  context,
                  MaterialPageRoute<num>(
                      builder: (context) => const NumberScreen()),
                ),
              )
                  .then((value) {
                 widget.gameLogic.textFieldEnabled = value;
                print(
                    'inside navigated future ${widget.gameLogic.textFieldEnabled}');
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
                    key: widget.gameLogic.globalFormKey,
                    child: TextFormField(
                      enabled: widget.gameLogic.textFieldEnabled,
                      controller:
                          widget.gameLogic.textEditingController,
                      decoration: const InputDecoration(
                        labelText: 'Enter your number',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.text_fields_rounded,
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      validator: (String? value) {
                        print(
                            'text ${widget.gameLogic.textEditingController.text}');
                        return widget.gameLogic
                            .validatorOfTextFormField(
                          value: value,
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
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                onPressed: () {
                  widget.gameLogic
                      .navigateToNumberDisplay(() async => await Navigator.push(
                    context,
                    MaterialPageRoute<num>(
                        builder: (context) => const NumberScreen()),
                  ),)
                      .then((value) =>
                          widget.gameLogic.textFieldEnabled = true);
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
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                onPressed: () {
                  if (!widget.gameLogic.textFieldEnabled) {
                    print('Disabled Button');
                    return;
                  } else if (!widget.gameLogic.globalFormKey.currentState!
                      .validate()) {
                    print(
                        'test${widget.gameLogic.textEditingController}');
                    return;
                  } else {
                    showDialog<void>(
                      context: context,
                      // barrierDismissible: barrierDismissible, false = user must tap button, true = tap outside dialog
                      builder: (BuildContext dialogContext) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        return AlertDialog(
                          title: Text(
                            widget.gameLogic.rightOrWrong(
                              userCalculation: widget.gameLogic.textEditingController.text,
                            ),
                          ),
                          content: Text(
                            widget.gameLogic.resultText(
                              result: widget.gameLogic.rightOrWrong(
                                userCalculation: widget.gameLogic.textEditingController.text,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: const Text('Check'),
              ),
            ],
          ),
        ],
      );}),
    ));
  }
}
