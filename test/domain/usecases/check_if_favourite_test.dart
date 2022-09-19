import 'package:pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/domain/usecases/check_if_favourite.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'check_if_favourite_test.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  late CheckIfFavourite usecase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = CheckIfFavourite(mockPokemonRepository);
  });

  test(
    'should get List of pokemons from the repository',
    () async {
      // arrange
      when(mockPokemonRepository.checkIfFavourite('name1'))
          .thenAnswer((_) => true);
      // act
      final result = usecase.execute(const Params('name1'));
      // assert
      expect(result, true);
      verify(mockPokemonRepository.checkIfFavourite('name1'));
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
