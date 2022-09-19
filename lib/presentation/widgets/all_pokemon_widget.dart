import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:pokedex/presentation/pages/home/home_screen_controller.dart';
import 'package:pokedex/presentation/widgets/pokemon_shimmer_widget.dart';
import 'package:pokedex/presentation/widgets/pokemon_widget.dart';

class AllPokemonWidget extends ConsumerStatefulWidget {
  const AllPokemonWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AllPokemonWidget> createState() => _AllPokemonWidgetState();
}

class _AllPokemonWidgetState extends ConsumerState<AllPokemonWidget> {
  PagingController<int, PokemonDetailEntity> _pagingController =
      PagingController<int, PokemonDetailEntity>(firstPageKey: 0);

  int pageLimit = 20;

  _onTapPokemon(PokemonDetailEntity pokemonDetail) {
    Navigator.of(context)
        .pushNamed('pokemonDetail', arguments: {'detail': pokemonDetail});
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<PokemonDetailEntity> newItems =
          await ref.read(homeScreenControllerProvider).getPokemons();
      final isLastPage = newItems.length < pageLimit;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> init() async {
    if (mounted) {
      List<PokemonDetailEntity> cachedPokemons =
          ref.read(pokemonListProvider.notifier).state;
      if (cachedPokemons.isNotEmpty) {
        _pagingController.itemList = cachedPokemons;
      }

      _pagingController.addPageRequestListener((pageKey) async {
        await _fetchPage(pageKey);
      });
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, PokemonDetailEntity>(
      key: const PageStorageKey('all_pokemons'),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      pagingController: _pagingController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        crossAxisCount: 3,
        mainAxisExtent: 186,
      ),
      builderDelegate: PagedChildBuilderDelegate<PokemonDetailEntity>(
        newPageProgressIndicatorBuilder: (context) =>
            const PokemonShimmerWidget(),
        firstPageProgressIndicatorBuilder: (context) => Wrap(
          runSpacing: 12,
          spacing: 10,
          children: List.generate(20, (index) => index)
              .map((i) => const PokemonShimmerWidget())
              .toList(),
        ),
        itemBuilder: (context, pokemon, index) => PokemonWidget(
          pokemonDetail: pokemon,
          onTap: () => _onTapPokemon(pokemon),
        ),
      ),
    );
  }
}
