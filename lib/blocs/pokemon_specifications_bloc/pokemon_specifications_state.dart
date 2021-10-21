import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:poke_info/domain/models/pokedexitem_class.dart';

@immutable
abstract class PokemonSpecificationsItemState extends Equatable {
  const PokemonSpecificationsItemState();
}

@immutable
class InitialPokemonSpecificationsItemState extends PokemonSpecificationsItemState {
  const InitialPokemonSpecificationsItemState();

  @override
  // TODO: implement props
  List<Object?> get props => [this.runtimeType];
}

@immutable
class LoadingPokemonSpecificationsItemState extends PokemonSpecificationsItemState {
  const LoadingPokemonSpecificationsItemState();

  @override
  // TODO: implement props
  List<Object?> get props => [this.runtimeType];
}

@immutable
class LoadedPokemonSpecificationsItemState extends PokemonSpecificationsItemState {
  const LoadedPokemonSpecificationsItemState({required this.pokedex, this.endPokedex = false});

  final bool endPokedex;
  final PokedexItem pokedex;

  @override
  // TODO: implement props
  List<Object?> get props => [pokedex, this.runtimeType];
}

@immutable
class FatalErrorPokemonSpecificationsItemState extends PokemonSpecificationsItemState {
  const FatalErrorPokemonSpecificationsItemState();

  @override
  // TODO: implement props
  List<Object?> get props => [this.runtimeType];
}
