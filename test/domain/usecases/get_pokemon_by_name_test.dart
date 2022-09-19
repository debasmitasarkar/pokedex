import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/domain/usecases/get_pokemon_by_name.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../entities/pokemon_entity_mock.dart';
import 'get_pokemons_test.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  late GetPokemonByName usecase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemonByName(mockPokemonRepository);
  });

  const PokemonDetailEntity pokemonDetail = mockEntity;

  test(
    'should get List of pokemons from the repository',
    () async {
      // arrange
      when(mockPokemonRepository.getPokemonByName('name1'))
          .thenAnswer((_) async => pokemonDetail);
      // act
      final result = await usecase.execute(const Params(name: 'name1'));
      // assert
      expect(result, mockEntity);
      verify(mockPokemonRepository.getPokemonByName('name1'));
      verifyNoMoreInteractions(mockPokemonRepository);
    },
  );
}
