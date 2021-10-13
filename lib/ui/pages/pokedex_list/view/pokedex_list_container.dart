import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_info/app_dependencies/app_dependencies.dart';
import 'package:poke_info/blocs/pokedex_list_cubit/pokedex_list_cubit.dart';

class PokedexListContainer extends StatelessWidget {
  const PokedexListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => PokedexListCubit(AppDependencies.of(context)!.pokemonsWeb) );
  }
}
