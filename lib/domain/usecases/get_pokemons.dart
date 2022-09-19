import 'package:pokedex/domain/entities/pokemon_response_entity.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/core/usecase/base_usecase.dart';

class GetPokemons extends BaseUseCase<Future<PokemonResponseEntity>, Params> {
  final PokemonRepository repo;
  const GetPokemons(this.repo);

  @override
  Future<PokemonResponseEntity> execute(Params params) async {
    return await repo.getPokemons(params.url);
  }
}

class Params {
  final String? url;
  const Params(
    this.url,
  );
}
