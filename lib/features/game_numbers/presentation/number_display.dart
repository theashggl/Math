import 'package:flutter/material.dart';
import 'package:flutter_apps/features/game_numbers/domain/use_cases/number_display_functionalities.dart';
import 'package:flutter_apps/service_locator.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';

//This page will show the numbers on the screen once the user hits start on the home page
// class NumberDisplay extends StatelessWidget {
//   const NumberDisplay({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: NumberScreen(
//       ),
//     );
//   }
// }

//Change variable name
class NumberScreen extends StatefulWidget {
  const NumberScreen({
    super.key,
  });
  @override
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  late GameListGeneration gameListGeneration;

  @override
  Widget build(BuildContext context) {
    gameListGeneration = GameListGeneration(
    diVariables: getIt<DIVariables>());
    print("backend call check ${gameListGeneration.answer}");
    return Scaffold(
      body: StreamBuilder<num>(
        stream: getIt<DIVariables>().outputStream,
        // initialData: gameListGeneration.answer,
        builder: (context, snapshot) {
          print('${snapshot.data} is the number');
          if((snapshot.connectionState==ConnectionState.active||
              snapshot.connectionState==ConnectionState.done)&&
              snapshot.hasData) {
            return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  key: const Key('buttonExit'),
                  child: const Text('Exit'),
                  onPressed: () {
                    print(snapshot.connectionState);
                    gameListGeneration.elevatedButtonPress(
                            ()=> Navigator.pop(context,gameListGeneration.answer)
                        , snapshot);
                  },
                ),
              ],
            ),
          );
          } else {
            print('${snapshot.connectionState} connection state');
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
