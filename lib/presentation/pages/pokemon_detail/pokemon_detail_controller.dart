import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:pokedex/domain/usecases/check_if_favourite.dart'
    as check_if_favourite;
import 'package:pokedex/domain/usecases/get_favourite_list.dart'
    as get_favourite_list;
import 'package:pokedex/domain/usecases/remove_from_favourites.dart'
    as remove_from_favourites;
import 'package:pokedex/domain/usecases/save_to_favourites.dart'
    as save_to_favourites;
import 'package:pokedex/presentation/injector.dart';
import 'package:pokedex/presentation/pages/home/home_screen_controller.dart';

final pokemonStateProvider = StateProvider.autoDispose<bool>((ref) => false);
final pokemonDetailControllerProvider =
    Provider.autoDispose<PokemonDetailController>(
        (ref) => PokemonDetailController(
              ref,
              checkIfFavouriteUsecase: Injector.checkIfFavouriteUsecase,
              getFavouriteListUsecase: Injector.getFavouriteListUsecase,
              saveToFavouritesUsecase: Injector.saveToFavouritesUsecase,
              removeFromFavouritesUseCase: Injector.removeFromFavouritesUseCase,
            ));

class PokemonDetailController {
  late ProviderRef ref;
  late save_to_favourites.SaveToFavourites saveToFavouritesUsecase;
  late get_favourite_list.GetFavouriteList getFavouriteListUsecase;
  late check_if_favourite.CheckIfFavourite checkIfFavouriteUsecase;
  late remove_from_favourites.RemoveFromFavourites removeFromFavouritesUseCase;

  static final PokemonDetailController _singleton =
      PokemonDetailController._internal();

  factory PokemonDetailController(
    ProviderRef reference, {
    required save_to_favourites.SaveToFavourites saveToFavouritesUsecase,
    required get_favourite_list.GetFavouriteList getFavouriteListUsecase,
    required check_if_favourite.CheckIfFavourite checkIfFavouriteUsecase,
    required remove_from_favourites.RemoveFromFavourites
        removeFromFavouritesUseCase,
  }) {
    _singleton.ref = reference;
    _singleton.checkIfFavouriteUsecase = checkIfFavouriteUsecase;
    _singleton.getFavouriteListUsecase = getFavouriteListUsecase;
    _singleton.removeFromFavouritesUseCase = removeFromFavouritesUseCase;
    _singleton.saveToFavouritesUsecase = saveToFavouritesUsecase;
    return _singleton;
  }

  PokemonDetailController._internal();

  void removeFromList(PokemonDetailEntity pokemon) {
    List<PokemonDetailEntity> favourites = ref.read(favouriteListProvider);
    favourites.remove(pokemon);
    ref.read(favouriteListProvider.notifier).state = [...favourites];
  }

  void addToList(PokemonDetailEntity pokemon) {
    List<PokemonDetailEntity> favourites = ref.read(favouriteListProvider);
    favourites.add(pokemon);
    ref.read(favouriteListProvider.notifier).state = [...favourites];
  }

  Future<void> markAsFavourite(PokemonDetailEntity pokemon) async {
    try {
      await saveToFavouritesUsecase
          .execute(save_to_favourites.Params(pokemon.name));
      ref.read(pokemonStateProvider.notifier).state = true;
      addToList(pokemon);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeFromFavourites(PokemonDetailEntity pokemon) async {
    try {
      await removeFromFavouritesUseCase
          .execute(remove_from_favourites.Params(pokemon.name));
      ref.read(pokemonStateProvider.notifier).state = false;
      removeFromList(pokemon);
    } catch (e) {
      log(e.toString());
    }
  }

  void checkIffavourite(String id) {
    try {
      bool result =
          checkIfFavouriteUsecase.execute(check_if_favourite.Params(id));
      ref.read(pokemonStateProvider.notifier).state = result;
    } catch (e) {
      log(e.toString());
    }
  }
}
