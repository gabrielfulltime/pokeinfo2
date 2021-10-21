import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_info/domain/models/pokedexitem_class.dart';
import 'package:poke_info/domain/services/pokeapi_web.dart';
import 'package:poke_info/blocs/pokemon_specifications_bloc/pokemon_specifications_state.dart';

class PokemonSpecificationsItemCubit extends Cubit<PokemonSpecificationsItemState> {
  PokemonSpecificationsItemCubit({required this.pokemonWebApi}) : super
      (InitialPokemonSpecificationsItemState());
  final PokemonWebApi pokemonWebApi;

  Future<void> load({required String nameOrId}) async {
    emit(LoadingPokemonSpecificationsItemState());
    await Future.delayed(Duration(milliseconds: 1000));
    try {
      final PokedexItem? pokedexItem = await pokemonWebApi.findA(nameOrId: nameOrId);
      if (pokedexItem!= null) emit(LoadedPokemonSpecificationsItemState(pokedex: pokedexItem));
    } catch (error) {
      emit(FatalErrorPokemonSpecificationsItemState());
    }
  }
}
