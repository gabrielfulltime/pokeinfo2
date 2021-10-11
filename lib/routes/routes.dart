import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poke_info/ui/pages/home_screen/view/home_screen_view.dart';
import 'package:poke_info/ui/pages/pokedex_list/view/pokedex_list_view.dart';

class Routes {
  static const String homeScreenRoute = "/";
  static const String pokedexListRoute = "/pokedex_list";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) =>  HomeScreenView());
      case pokedexListRoute:
        return MaterialPageRoute(builder: (_) =>  PokedexLitsView());
      default:
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
}
