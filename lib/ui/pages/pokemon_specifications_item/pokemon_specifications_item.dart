import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_info/app_dependencies/app_dependencies.dart';
import 'package:poke_info/blocs/pokemon_specifications_bloc/pokemon_specifications_cubit.dart';
import 'package:poke_info/domain/models/pokedexitem_class.dart';
import 'package:poke_info/blocs/pokemon_specifications_bloc/pokemon_specifications_item_cubit.dart';
import 'package:poke_info/blocs/pokemon_specifications_bloc/pokemon_specifications_state.dart';

class PokemonSpecificationsItem extends StatelessWidget {
  const PokemonSpecificationsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext blocContext) =>
          PokemonSpecificationsItemCubit(pokemonWebApi: AppDependencies.of(context)!.pokemonsWeb),
      child: BlocBuilder<PokemonSpecificationsItemCubit, PokemonSpecificationsItemState>(builder: (blocContext, state) {
        final int currentId = context.read<PokemonSpecificationsCubit>().state;
        if (state is InitialPokemonSpecificationsItemState || state is LoadingPokemonSpecificationsItemState) {
          blocContext.read<PokemonSpecificationsItemCubit>().load(nameOrId: currentId.toString());
          return _loading();
        }
        if (state is FatalErrorPokemonSpecificationsItemState)
          return Container(
            child: Center(
              child: Text("Deu erro"
                  " mermao"),
            ),
          );
        if (state is LoadedPokemonSpecificationsItemState) {
          final PokedexItem pokemon = state.pokedex;
          if (pokemon.pokemon.pokedexId != currentId)
            blocContext.read<PokemonSpecificationsItemCubit>().load(nameOrId: currentId.toString());
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${state.pokedex.pokemon.pokemonName}"),
                      Text("N° ${state.pokedex.pokemon.pokedexId}"),
                    ],
                  ),
                  background: Image.network(pokemon.pokemon.urlImage),
                  titlePadding: EdgeInsets.all(8.0),
                  centerTitle: true,
                ),
                pinned: true,
                snap: false,
                floating: true,
              ),

              SliverToBoxAdapter(
                child: Text("${pokemon}"),
              ),

            ],
          );
        }
        return Container(
          child: Center(
            child: Text("${currentId}"),
          ),
        );
      }),
    );
  }

  Container _loading() => Container(child: Center(child: CircularProgressIndicator()));
}
