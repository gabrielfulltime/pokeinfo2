import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:poke_info/app_dependencies/app_dependencies.dart';
import 'package:poke_info/domain/services/pokeapi_web.dart';
import 'package:poke_info/routes/routes.dart';


void main() {
  runApp(const MaterialApp(
    home: Pokeinfo(pokemonWebApi: PokemonWebApi(),),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  ));
}

class Pokeinfo extends StatelessWidget {
  const Pokeinfo({Key? key, required this.pokemonWebApi}) : super(key: key);
  final PokemonWebApi pokemonWebApi;
  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      pokemonsWeb: pokemonWebApi,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData.dark(),
        initialRoute: Routes.homeScreenRoute,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
