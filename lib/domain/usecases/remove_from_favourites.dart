import 'package:pokedex/core/usecase/base_usecase.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class RemoveFromFavourites extends BaseUseCase<Future<bool>, Params> {
  final PokemonRepository repo;
  const RemoveFromFavourites(this.repo);

  @override
  Future<bool> execute(Params params) async {
    return await repo.removeFromFavourites(params.id);
  }
}

class Params {
  final String id;
  const Params(
    this.id,
  );
}
