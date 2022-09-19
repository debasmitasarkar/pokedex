import 'package:pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/domain/entities/basestat_entity.dart';
import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';

const BaseStatEntity baseStatEntity = BaseStatEntity(
  attack: 1,
  avgPower: 2,
  defense: 3,
  hp: 4,
  specialAttack: 5,
  specialDefense: 6,
  speed: 7,
);

const PokemonDetailEntity mockEntity = PokemonDetailEntity(
  baseStat: baseStatEntity,
  bmi: 10,
  height: 10,
  imageUrl:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
  id: 1,
  isFavourite: false,
  name: 'Pokemon 1',
  speciesTypes: ['Fire', 'Grass'],
  weight: 2,
);

const PokemonEntity mockPokemonEntity =
    PokemonEntity(name: 'name1', url: 'url');

const List<PokemonEntity> mockPokemonEntityList = [
  PokemonEntity(name: 'bulbasaur', url: 'https://pokeapi.co/api/v2/pokemon/1/'),
  PokemonEntity(name: 'ivysaur', url: 'https://pokeapi.co/api/v2/pokemon/2/')
];
