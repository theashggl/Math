import 'package:flutter_apps/features/game_numbers/domain/use_cases/number_display_functionalities.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';
import 'package:flutter_apps/shared/widgets/home_page_inherited_widget.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void configureDependencies() {
  // HomePageInheritedWidget inheritedProvider=HomePageInheritedWidget.of(context);
  getIt.registerSingleton<GameLogic>(GameLogic());
  getIt.registerLazySingleton<DIVariables>(() => DIVariables(
      selectedOperation: getIt<GameLogic>().selectedOperation,
      counter: getIt<GameLogic>().operandCount,
      digits: getIt<GameLogic>().dropDownIndex.toString()));
}
