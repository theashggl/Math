import 'package:flutter_apps/features/game_numbers/domain/use_cases/number_display_functionalities.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/game_parameters.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void loadDependencies() {
  // HomePageInheritedWidget inheritedProvider=HomePageInheritedWidget.of(context);
  getIt.registerSingleton<GameParameters>(GameParameters());
  getIt.registerLazySingleton<DIVariables>(() => DIVariables(
      counter: getIt<GameParameters>().operandCount,
      digits: getIt<GameParameters>().dropDownIndex.toString()));
}
