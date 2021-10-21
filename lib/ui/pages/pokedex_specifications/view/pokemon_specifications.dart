import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_info/blocs/pokemon_specifications_bloc/pokemon_specifications_cubit.dart';
import 'package:poke_info/ui/pages/pokemon_specifications_item/pokemon_specifications_item.dart';

class PokemonSpecificationsView extends StatefulWidget {
  const PokemonSpecificationsView({Key? key}) : super(key: key);

  @override
  _PokemonSpecificationsViewState createState() => _PokemonSpecificationsViewState();
}

class _PokemonSpecificationsViewState extends State<PokemonSpecificationsView> {
  PageController _pageController = PageController(initialPage: 3);

  @override
  Widget build(BuildContext context) {
    final int initialPage = 3;
    return Scaffold(
      body: BlocBuilder<PokemonSpecificationsCubit, int>(
        builder: ((BuildContext context, state) {
          return PageView(
            onPageChanged: (int currentPage) async {
              if (currentPage == initialPage - 1) {
                await Future.delayed(Duration(milliseconds: 100));
                if (currentPage == initialPage - 1) context.read<PokemonSpecificationsCubit>().decrement();
                await Future.delayed(Duration(milliseconds: 500));
                _pageController.jumpToPage(initialPage);
              }
              if (currentPage == initialPage) {}

              if (currentPage == initialPage + 1) {
                await Future.delayed(Duration(milliseconds: 100));
                if (currentPage == initialPage + 1) context.read<PokemonSpecificationsCubit>().increment();
                await Future.delayed(Duration(milliseconds: 500));
                _pageController.jumpToPage(initialPage);
              }
            },
            controller: _pageController,
            children: pageViewChildren(),
          );
        }),
      ),
    );
  }

  List<Widget> pageViewChildren() {
    return [
      _awaitContainer(),
      _awaitContainer(),
      _awaitContainer(),
      PokemonSpecificationsItem(),
      _awaitContainer(),
      _awaitContainer(),
      _awaitContainer(),
    ];
  }

  Container _awaitContainer() {
    return Container();
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:poke_info/app_dependencies/app_dependencies.dart';
// import 'package:poke_info/domain/models/pokedexitem_class.dart';
// import 'package:poke_info/ui/pages/pokedex_specifications/pokemon_specifications_item_cubit.dart';
// import 'package:poke_info/ui/pages/pokedex_specifications/pokemon_specifications_state.dart';
// import 'package:poke_info/ui/pages/pokedex_specifications/widgets/pokemon_specifications_item.dart';
//
// class PokemonSpecificationsView extends StatefulWidget {
//   PokemonSpecificationsView({
//     Key? key,
//     required this.pokedexId,
//   });
//
//   final int pokedexId;
//
//   @override
//   _PokemonSpecificationsViewState createState() => _PokemonSpecificationsViewState();
// }
//
// class _PokemonSpecificationsViewState extends State<PokemonSpecificationsView> {
//
//   final PageController _pageController = PageController(initialPage: 1);
//   int pokedexId = 2;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         physics: BouncingScrollPhysics(),
//         controller: _pageController,
//         onPageChanged: (pageNumber){
//           if (pageNumber ==2) {
//
//           setState(() {
//             pokedexId++;
//             _pageController.jumpToPage(1);
//
//           });
//           };
//         if (pageNumber == 0) {
//           setState(() {
//             pokedexId--;
//             _pageController.jumpToPage(1);
//
//           });
//         }
//         ;
//       },
//         children: [
//           PokemonSpecificationsItem(pokedexItem: pokedexId -1,),
//           PokemonSpecificationsItem(pokedexItem: pokedexId,),
//           PokemonSpecificationsItem(pokedexItem: pokedexId +1,),
//         ],
//       )
//     );
//   }
// }
