import 'package:flutter/material.dart';
import 'package:poke_info/ui/pages/home_screen/widgets/pokedex_feature_widget.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              PokedexFeature(),
            ],
          ),
        ));
  }
}
