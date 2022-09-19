import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/domain/usecases/get_pokemons.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../entities/pokemon_response_entity_mock.dart';
import 'get_pokemons_test.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  late GetPokemons usecase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemons(mockPokemonRepository);
  });

  test(
    'should pokemonresponse from the repository',
    () async {
      // arrange
      when(mockPokemonRepository.getPokemons(any))
          .thenAnswer((_) async => mockPokemonResponseEntity);
      // act
      final result = await usecase.execute(const Params(''));
      // assert
      expect(result, mockPokemonResponseEntity);
      verify(mockPokemonRepository.getPokemons(''));
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
