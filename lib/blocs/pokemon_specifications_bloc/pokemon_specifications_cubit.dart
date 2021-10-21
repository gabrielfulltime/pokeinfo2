import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonSpecificationsCubit extends Cubit<int> {
  PokemonSpecificationsCubit(int initialState) : super(initialState);

  Future<void> increment() async{
    if (state <= 898) {
      emit(state + 1);
    };
  }

  Future<void> decrement() async {
    if (state >= 1) {
      emit(state - 1);
    };
  }
}
