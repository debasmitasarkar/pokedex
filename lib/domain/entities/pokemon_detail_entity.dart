import 'package:equatable/equatable.dart';
import 'package:pokedex/domain/entities/basestat_entity.dart';

class PokemonDetailEntity extends Equatable {
  final int id;
  final String name;
  final List<String> speciesTypes;
  final String imageUrl;
  final int height;
  final int weight;
  final double bmi;
  final BaseStatEntity baseStat;
  final bool isFavourite;

  const PokemonDetailEntity({
    required this.baseStat,
    required this.bmi,
    required this.height,
    required this.imageUrl,
    required this.id,
    required this.isFavourite,
    required this.name,
    required this.speciesTypes,
    required this.weight,
  });

  @override
  List<Object?> get props => [id, name];
}
