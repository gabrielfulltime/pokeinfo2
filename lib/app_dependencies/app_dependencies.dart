import 'package:flutter/material.dart';
import 'package:poke_info/domain/services/pokeapi_web.dart';

class AppDependencies extends InheritedWidget {
  // final PokemonsDao pokemonsDao;
  final PokemonWebApi pokemonsWeb;

  AppDependencies({
    // required this.pokemonsDao,
    required this.pokemonsWeb,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return
        // pokemonsDao != oldWidget.pokemonsDao ||
        pokemonsWeb != oldWidget.pokemonsWeb;
  }

  static AppDependencies? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppDependencies>();
}
