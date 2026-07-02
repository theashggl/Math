import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_numbers/presentation/number_display.dart';
import 'package:flutter_apps/shared/widgets/home_page_inherited_widget.dart';

class GameInformationBody extends StatefulWidget {
  const GameInformationBody({
    super.key,
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
    final HomePageInheritedWidget inheritedProvider =
        HomePageInheritedWidget.of(context);
    print(
        'inherited data: ${inheritedProvider.gameObject.operationTextInHomePage}');
    return Center(
        child: SingleChildScrollView(
      child: ListenableBuilder(
          listenable: inheritedProvider.gameObject,
          builder: (BuildContext context, Widget? child) {
            return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Digits: '),
              Text(
                (inheritedProvider.gameObject.dropDownIndex + 1).toString(),
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                ),
              ),
              const Text('Count of operands: '),
              Text(
                inheritedProvider.gameObject.operandCount.toString(),
                style: const TextStyle(color: Colors.blue, fontSize: 40),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          const Text('Mathematical Operation: '),
          //Listening to the change in the operationTextInHomePage variable
          Text(
            inheritedProvider.gameObject.operationTextInHomePage,
            style: const TextStyle(color: Colors.blue, fontSize: 40),
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
              inheritedProvider.gameObject
                  .navigateToNumberDisplay(
                () async => await Navigator.push(
                  context,
                  MaterialPageRoute<num>(
                      builder: (context) => const NumberScreen()),
                ),
              )
                  .then((value) {
                  inheritedProvider.gameObject.textFieldEnabled = value;
                print(
                    'inside navigated future ${inheritedProvider.gameObject.textFieldEnabled}');
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
                    key: inheritedProvider.gameObject.globalFormKey,
                    child: TextFormField(
                      enabled: inheritedProvider.gameObject.textFieldEnabled,
                      controller:
                          inheritedProvider.gameObject.textEditingController,
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
                            'text ${inheritedProvider.gameObject.textEditingController.text}');
                        return inheritedProvider.gameObject
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
                  inheritedProvider.gameObject
                      .navigateToNumberDisplay(() async => await Navigator.push(
                    context,
                    MaterialPageRoute<num>(
                        builder: (context) => const NumberScreen()),
                  ),)
                      .then((value) =>
                          inheritedProvider.gameObject.textFieldEnabled = true);
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
                  if (!inheritedProvider.gameObject.textFieldEnabled) {
                    print('Disabled Button');
                    return;
                  } else if (!inheritedProvider
                      .gameObject.globalFormKey.currentState!
                      .validate()) {
                    print(
                        'test${inheritedProvider.gameObject.textEditingController}');
                    return;
                  } else {
                    showDialog<void>(
                      context: context,
                      // barrierDismissible: barrierDismissible, false = user must tap button, true = tap outside dialog
                      builder: (BuildContext dialogContext) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        return AlertDialog(
                          title: Text(
                            inheritedProvider.gameObject.rightOrWrong(
                              userCalculation: inheritedProvider
                                  .gameObject.textEditingController.text,
                            ),
                          ),
                          content: Text(
                            inheritedProvider.gameObject.resultText(
                              result: inheritedProvider.gameObject.rightOrWrong(
                                userCalculation: inheritedProvider
                                    .gameObject.textEditingController.text,
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
