import 'package:pokedex/domain/entities/pokemon_response_entity.dart';

import 'pokemon_entity_mock.dart';

const PokemonResponseEntity mockPokemonResponseEntity = PokemonResponseEntity(
  next: 'https://pokeapi.co/api/v2/pokemon?offset=10&limit=10',
  pokemons: mockPokemonEntityList,
);
