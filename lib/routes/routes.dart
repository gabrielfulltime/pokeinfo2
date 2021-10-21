
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poke_info/app_dependencies/app_dependencies.dart';
import 'package:poke_info/domain/models/pokedexitem_class.dart';
import 'package:poke_info/ui/pages/home_screen/view/home_screen_view.dart';
import 'package:poke_info/ui/pages/pokedex_list/view/pokedex_list_view.dart';
import 'package:poke_info/ui/pages/pokedex_specifications/view/pokemon_specifications.dart';
import 'package:poke_info/ui/pages/pokedex_specifications/view/pokemon_specifications_container.dart';

class Routes {
  
  static const String homeScreenRoute = "/";
  static const String pokedexListRoute = "/pokedex_list";
  static const String pokemonSpecifications = "/pokedex_list/pokemon_specifications";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;
    
    switch (settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) =>  HomeScreenView());
      case pokedexListRoute:
        return MaterialPageRoute(builder: (_) =>  PokedexListView(repository: AppDependencies.of(_)!.pokemonsWeb,));
      case pokemonSpecifications:
        if (args is int) return MaterialPageRoute(builder: (_) => PokemonSpecificationsContainer(pokedexId: args,));

        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text("Erro na rota"),
          ),
        ),
      );
  }
}
