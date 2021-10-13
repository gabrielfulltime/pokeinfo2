import 'package:flutter/material.dart';

class PokemonSpecifications extends StatefulWidget {
  const PokemonSpecifications({Key? key}) : super(key: key);

  @override
  _PokemonSpecificationsState createState() => _PokemonSpecificationsState();
}

class _PokemonSpecificationsState extends State<PokemonSpecifications> {
  final PageController _controller = PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        Scaffold(body: Center(child: Container(child: Text("cont1")))),
        Scaffold(body: Center(child: Container(child: Text("cont2")))),
        Scaffold(body: Center(child: Container(child: Text("cont3")))),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
