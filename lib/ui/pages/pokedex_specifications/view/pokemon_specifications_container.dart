import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_info/blocs/pokemon_specifications_bloc/pokemon_specifications_cubit.dart';
import 'package:poke_info/ui/pages/pokedex_specifications/view/pokemon_specifications.dart';

class PokemonSpecificationsContainer extends StatelessWidget {
  const PokemonSpecificationsContainer({Key? key, required this.pokedexId}) : super(key: key);
  final int pokedexId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => PokemonSpecificationsCubit(pokedexId),
      child: PokemonSpecificationsView(),
    );
  }
}
