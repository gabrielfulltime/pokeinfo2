import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_info/domain/models/pokedexitem_class.dart';
import 'package:poke_info/domain/services/pokeapi_web.dart';

class PokedexListCubit extends Cubit<List<PokedexItem>> {
  PokedexListCubit(this.pokemonWebApi) : super([]);
final PokemonWebApi pokemonWebApi;
  
  Future<void> loadPokedex(int startPoint,int endPoint ) async {
    final List<PokedexItem> pokedex =
    await pokemonWebApi.findAllPokedex(startPoint: startPoint, endPoint: endPoint );
    emit(pokedex);
  }
}