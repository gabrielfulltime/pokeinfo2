import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_info/domain/models/pokedexitem_class.dart';
import 'package:poke_info/domain/services/pokeapi_web.dart';

class PokedexListCubit extends Cubit<List<PokedexItem>> {
  PokedexListCubit(this.pokemonWebApi) : super([]);
final PokemonWebApi pokemonWebApi;
  
  Future<void> loadPokedex(int i) async {
    final List<PokedexItem> pokedex =
    await pokemonWebApi.findAllPokedex(point: i);
    emit(pokedex);
  }
}