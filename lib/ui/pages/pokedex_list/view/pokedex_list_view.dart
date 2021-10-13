import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:poke_info/domain/models/pokedexitem_class.dart';
import 'package:poke_info/domain/services/pokeapi_web.dart';
import 'package:poke_info/ui/pages/pokedex_specifications/view/pokedex_specifications.dart';

class PokedexListView extends StatefulWidget {
  final PokemonWebApi repository;

  @override
  State<PokedexListView> createState() => _PokedexListViewState();

  PokedexListView({required this.repository});
}

class _PokedexListViewState extends State<PokedexListView> {
  final PokemonWebApi _fetchPokemonsWeb = new PokemonWebApi();
  final _pagingController = PagingController<int, PokedexItem>(firstPageKey: 1);
  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
    scroll.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pokedex", style: _styleWhite()),
                LimitedBox(maxHeight: 50, child: Image.asset("images/pikachu.png"))
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.sync(() => _pagingController.refresh());
          },
          child: CustomScrollView(
            controller: scroll,
            slivers: <Widget>[
              SliverToBoxAdapter(child: Container()),
              PagedSliverGrid<int, PokedexItem>(
                showNewPageErrorIndicatorAsGridChild: false,
                showNoMoreItemsIndicatorAsGridChild: false,
                showNewPageProgressIndicatorAsGridChild: false,
                pagingController: _pagingController,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250, childAspectRatio: 5 / 5, crossAxisSpacing: 10, mainAxisSpacing: 10),
                builderDelegate:
                PagedChildBuilderDelegate<PokedexItem>(itemBuilder: (BuildContext context, item, int index) {
                  List<Color?> colors = [];

                  for (String type in item.type!) {
                    colors.add(PokedexItem.colorsType[type]);
                  }

                  return Material(
                    color: Colors.black12,
                    child: InkWell(
                      overlayColor: MaterialStateColor.resolveWith((states) => colors[0]!),
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            PokemonSpecifications()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(item.pokemon.pokemonName.toUpperCase(), style: _styleWhite()),
                                  Text(
                                    "Nº ${item.pokemon.pokedexId.toString().padLeft(3, "0")}",
                                    style: _styleWhite(),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Hero(
                                  tag: "pokemon$index",
                                  child: Image.network(
                                    item.pokemon.urlImage,
                                    color: (item.found ? null : Colors.black),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: _rowTypes(item.type!, colors),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }

  List<Widget> _rowTypes(List<String> types, List<Color?> colors) {
    List<Widget> pokedex = <Widget>[];
    for (int i = 0; i < types.length; i++) {
      print("tentei por os tipos");
      pokedex.add(Container(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("${types[i].toUpperCase()}", style: _styleWhite()),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colors[i],
        ),
      ));
    }
    return pokedex;
  }

  TextStyle _styleWhite() {
    return TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  }

  _scrollListener() {
    if (scroll.offset >= scroll.position.maxScrollExtent - 150 &&
        _pagingController.value.status != PagingStatus.ongoing) {
      _pagingController.nextPageKey = _pagingController.itemList!.length + 1;
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    print(pageKey);
    int endPoint = pageKey + 9;
    if (endPoint >= 898) endPoint = 898;
    try {
      final List<PokedexItem> newPage = await _fetchPokemonsWeb.findAllPokedex(point: pageKey);
      print(newPage);
      final bool isLastPage = endPoint <= 898;
      if (isLastPage) {
        _pagingController.appendLastPage(newPage);
      } else {
        final int nextPageKey = pageKey + 1;
        _pagingController.appendPage(newPage, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
