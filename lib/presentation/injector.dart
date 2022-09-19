import 'package:pokedex/data/datasources/local_datasource/local_datasource.dart';
import 'package:pokedex/data/datasources/remote_datasource/remote_datasource.dart';
import 'package:pokedex/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/domain/usecases/check_if_favourite.dart';
import 'package:pokedex/domain/usecases/get_favourite_list.dart';
import 'package:pokedex/domain/usecases/get_pokemon_by_name.dart';
import 'package:pokedex/domain/usecases/get_pokemons.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/domain/usecases/remove_from_favourites.dart';
import 'package:pokedex/domain/usecases/save_to_favourites.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Injector {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static RemoteDataSource remoteDataSource = RemoteDataSource(http.Client());
  static LocalDatasource localDatasource = LocalDatasource(sharedPreferences);
  static PokemonRepository pokemonRepository = PokemonRepositoryImpl(
      localDatasource: localDatasource, dataSource: remoteDataSource);
  static GetPokemons getPokemonsUsecase = GetPokemons(pokemonRepository);
  static GetPokemonByName getPokemonByNameUsecase =
      GetPokemonByName(pokemonRepository);
  static CheckIfFavourite checkIfFavouriteUsecase =
      CheckIfFavourite(pokemonRepository);
  static SaveToFavourites saveToFavouritesUsecase =
      SaveToFavourites(pokemonRepository);
  static GetFavouriteList getFavouriteListUsecase =
      GetFavouriteList(pokemonRepository);
  static RemoveFromFavourites removeFromFavouritesUseCase =
      RemoveFromFavourites(pokemonRepository);
}
