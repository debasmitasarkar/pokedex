import 'package:pokedex/core/usecase/base_usecase.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';

class CheckIfFavourite extends BaseUseCase<bool, Params> {
  final PokemonRepository repo;
  const CheckIfFavourite(this.repo);

  @override
  bool execute(Params params) {
    return repo.checkIfFavourite(params.id);
  }
}

class Params {
  final String id;
  const Params(
    this.id,
  );
}
