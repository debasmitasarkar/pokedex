import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:pokedex/domain/entities/pokemon_response_entity.dart';

abstract class PokemonRepository {
  Future<PokemonResponseEntity> getPokemons(String? url);
  Future<PokemonDetailEntity> getPokemonByName(String name);
  List<String> fetchFavourites();
  bool checkIfFavourite(String id);
  Future<bool> saveToFavouritesList(String id);
  Future<bool> removeFromFavourites(String id);
}
