import 'package:flutter/material.dart';
import 'package:flutter_apps/shared/game_information_logic.dart';

//By extending Inherited widget data can be passed directly to any of the child widgets.
class HomePageInheritedWidget extends InheritedNotifier<GameLogic>{
  const HomePageInheritedWidget({
    super.key,//gets the key from super class
    required this.gameObject,
    required super.child,//gets the top node of the widget tree that needs access to the data
}):super(notifier: gameObject);

  //data to be made accessible for children
  final GameLogic gameObject;

  //Notifies the changes in data down the widget tree when the class is recreated due to changes. It gets called somewhere somehow by Flutter framework internally
  @override
  bool updateShouldNotify(covariant HomePageInheritedWidget oldWidget) {
    print('checking value change and the call to the method \n old value: ${oldWidget.gameObject.dropDownIndex}\n new value: ${gameObject.dropDownIndex}');
    return
      identical(oldWidget.gameObject, gameObject);
  }

  //method to make the data accessible to the child widgets that need it.
  static HomePageInheritedWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomePageInheritedWidget>();
  }

  static HomePageInheritedWidget of(BuildContext context){
    final HomePageInheritedWidget? result = maybeOf(context);
    assert(result!=null,'Null object');
    return result!;
  }
}