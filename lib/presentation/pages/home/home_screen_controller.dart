import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/domain/entities/pokemon_response_entity.dart';
import 'package:pokedex/domain/usecases/get_favourite_list.dart'
    as get_favourite_list;
import 'package:pokedex/domain/usecases/get_pokemon_by_name.dart'
    as get_pokemon_by_name;
import 'package:pokedex/domain/usecases/get_pokemons.dart' as get_pokemons;
import 'package:pokedex/presentation/injector.dart';

final loaderStateProvider = StateProvider<bool>((ref) => false);

final pokemonListProvider =
    StateProvider<List<PokemonDetailEntity>>((ref) => []);

final favouriteListProvider =
    StateProvider<List<PokemonDetailEntity>>((ref) => []);

final homeScreenControllerProvider =
    Provider.autoDispose<HomeScreenController>((ref) => HomeScreenController(
          ref,
          getPokemonsUsecase: Injector.getPokemonsUsecase,
          getPokemonsByNameUsecase: Injector.getPokemonByNameUsecase,
          getFavouriteListUsecase: Injector.getFavouriteListUsecase,
        ));

class HomeScreenController {
  late ProviderRef ref;
  late get_pokemons.GetPokemons getPokemonsUsecase;
  late get_pokemon_by_name.GetPokemonByName getPokemonsByNameUsecase;
  late get_favourite_list.GetFavouriteList getFavouriteListUsecase;

  static final HomeScreenController _singleton =
      HomeScreenController._internal();

  factory HomeScreenController(
    ProviderRef reference, {
    required get_pokemons.GetPokemons getPokemonsUsecase,
    required get_pokemon_by_name.GetPokemonByName getPokemonsByNameUsecase,
    required get_favourite_list.GetFavouriteList getFavouriteListUsecase,
  }) {
    _singleton.ref = reference;
    _singleton.getPokemonsUsecase = getPokemonsUsecase;
    _singleton.getPokemonsByNameUsecase = getPokemonsByNameUsecase;
    _singleton.getFavouriteListUsecase = getFavouriteListUsecase;
    return _singleton;
  }

  HomeScreenController._internal();

  PokemonResponseEntity? responseEntity;

  reset() {
    responseEntity = null;
    ref.read(pokemonListProvider.notifier).state = [];
  }

  List<PokemonDetailEntity> getCachedPokemonList() {
    return ref.read(pokemonListProvider.notifier).state;
  }

  Future<List<PokemonDetailEntity>> getPokemons() async {
    ref.read(loaderStateProvider.notifier).state = true;

    List<PokemonDetailEntity> pokemonDetailList = [];
    try {
      responseEntity = await getPokemonsUsecase
          .execute(get_pokemons.Params(responseEntity?.next));

      for (PokemonEntity pokemon in responseEntity!.pokemons) {
        PokemonDetailEntity detail = await getPokemonsByName(pokemon.name);
        pokemonDetailList.add(detail);
      }
      List<PokemonDetailEntity> oldList = [
        ...ref.read(pokemonListProvider.notifier).state
      ];

      ref.read(pokemonListProvider.notifier).state = oldList
        ..addAll(pokemonDetailList);
      ref.read(loaderStateProvider.notifier).state = false;
      return pokemonDetailList;
    } catch (e) {
      ref.read(loaderStateProvider.notifier).state = false;
      rethrow;
    }
  }

  Future<PokemonDetailEntity> getPokemonsByName(String name) async {
    return getPokemonsByNameUsecase
        .execute(get_pokemon_by_name.Params(name: name));
  }

  Future<List<PokemonDetailEntity>> getFavourites() async {
    List<PokemonDetailEntity> pokemonDetailList = [];
    try {
      List<String> favourites =
          getFavouriteListUsecase.execute(get_favourite_list.Params());
      if (favourites.isNotEmpty) {
        for (String name in favourites) {
          PokemonDetailEntity detail = await getPokemonsByName(name);
          pokemonDetailList.add(detail);
        }
      }
      ref.read(favouriteListProvider.notifier).state = pokemonDetailList;
      return pokemonDetailList;
    } catch (e) {
      rethrow;
    }
  }
}
