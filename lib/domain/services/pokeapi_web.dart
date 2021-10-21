import 'dart:convert';

// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:poke_info/domain/models/pokedexitem_class.dart';

class PokemonWebApi {
  const PokemonWebApi({Key? key});
  Future<List<PokedexItem>> findAll(final int pokemonQuantity) async {
    Response response = await _pokedexListRequest(pokemonQuantity);
    List<PokedexItem> allPokedex = _toPokedexList(response);
    return allPokedex;
  }

  Future<List<PokedexItem>> findAllPokedex({required int startPoint, required int endPoint}) async {
    final List<PokedexItem> allPokedex = [];
    for (int i = startPoint; i <= endPoint; i++) {

      PokedexItem? pokemonItem = await findA(nameOrId: i.toString());
      print (pokemonItem);
      if (pokemonItem == null) break;
      allPokedex.add(pokemonItem);
    }
    return allPokedex;
  }

  Future<PokedexItem?> findA({String nameOrId = ""}) async {
    Response response = await _requisicaoPokemonItem(nameOrId);
    if (response.statusCode != 200) {
      return null;
    }
    PokedexItem pokedexItem = _toPokemonItem(response);
    return pokedexItem;
  }

  Future<dynamic> findType(final String type) async {
    final String lowerType = type.toLowerCase();
    final Uri uri = Uri.parse("https://pokeapi.co/api/v2/type/$lowerType");
    Response response = await http.get(uri).timeout(Duration(seconds: 5));
    if (response.statusCode != 200) {
      return null;
    }
    return response.body;
  }

  Future<Response> _pokedexListRequest(int quantidadePokemon) async {
    final Uri uri = Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=$quantidadePokemon");
    return await http.get(uri).timeout(Duration(seconds: 5));
  }

  PokedexItem _toPokemonItem(Response response) {
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);

    PokedexItem? pokedexItem = PokedexItem.fromJson(json: decodedJson);
    return pokedexItem;
  }

  List<PokedexItem> _toPokedexList(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body)["results"];
    int i = 0;

    List<PokedexItem> totalPokedex = [];
    for (Map<String, dynamic> pokemonEspecie in decodedJson) {
      i++;
      final PokedexItem pokedexItem = PokedexItem.fromJson(json: pokemonEspecie, i: i);
      totalPokedex.add(pokedexItem);
    }
    return totalPokedex;
  }

  Future<Response> _requisicaoPokemonItem(String name) async {
    final String lowerName = name.toLowerCase();
    final String url = "https://pokeapi.co/api/v2/pokemon/$lowerName";
    final Response response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 5));
    return response;
  }
}
