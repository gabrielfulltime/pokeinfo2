import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:poke_info/app_dependencies/app_dependencies.dart';
import 'package:poke_info/routes/routes.dart';

class PokedexFeature extends StatelessWidget {
  const PokedexFeature({Key? key}) : super(key: key);
  static const pokedexImage = "images/logo_pokedex.png";

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        child: Center(
          child: Material(
              color: Colors.grey[800],
              child: InkResponse(
                onTap: () {
                  Navigator.pushNamed(context, Routes.pokedexListRoute);
                },
                child: Column(
                  children: [
                    Text(AppLocalizations.of(context)!.pokedex),
                    Image.asset(pokedexImage),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
