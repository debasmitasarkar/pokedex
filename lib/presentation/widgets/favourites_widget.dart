import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:pokedex/presentation/pages/home/home_screen_controller.dart';
import 'package:pokedex/presentation/widgets/pokemon_widget.dart';

class FavouritesWidget extends ConsumerStatefulWidget {
  const FavouritesWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FavouritesWidgetState();
}

class _FavouritesWidgetState extends ConsumerState<FavouritesWidget> {
  _onTapPokemon(PokemonDetailEntity pokemonDetail) {
    Navigator.of(context)
        .pushNamed('pokemonDetail', arguments: {'detail': pokemonDetail});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      List<PokemonDetailEntity> favourites = ref.watch(favouriteListProvider);
      return favourites.isEmpty
          ? const Center(
              child: Text('No items! Add pokemons to favourites.'),
            )
          : GridView.builder(
              key: const PageStorageKey('favourite_pokemons'),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                crossAxisCount: 3,
                mainAxisExtent: 186,
              ),
              itemCount: favourites.length,
              itemBuilder: (context, index) => PokemonWidget(
                pokemonDetail: favourites[index],
                onTap: () => _onTapPokemon(favourites[index]),
              ),
            );
    });
  }
}
