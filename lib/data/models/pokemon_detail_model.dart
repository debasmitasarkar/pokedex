// To parse this JSON data, do
//
//     final pokemonDetail = pokemonDetailFromJson(jsonString);

import 'dart:convert';

import 'package:pokedex/domain/entities/basestat_entity.dart';
import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';

PokemonDetail pokemonDetailFromJson(String str) =>
    PokemonDetail.fromJson(json.decode(str));

class PokemonDetail extends PokemonDetailEntity {
  PokemonDetail({
    required this.height,
    required this.id,
    required this.name,
    this.pastTypes,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  }) : super(
          id: id,
          bmi: getBmi(height, weight),
          height: height,
          baseStat: getBaseStat(stats),
          imageUrl: sprites.other?.officialArtwork?.frontDefault ??
              'https://www.freeiconspng.com/thumbs/pokeball-png/file-pokeball-png-0.png',
          isFavourite: false,
          name: name,
          speciesTypes: types.map((t) => t.type.name).toList(),
          weight: weight,
        );
  final int height;
  final int id;
  final String name;
  final List<dynamic>? pastTypes;
  final Sprites sprites;
  final List<BaseStat> stats;
  final List<Type> types;
  final int weight;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
        height: json["height"],
        id: json["id"],
        name: json["name"],
        pastTypes: json["past_types"] == null
            ? null
            : List<dynamic>.from(json["past_types"].map((x) => x)),
        sprites: Sprites.fromJson(json["sprites"]),
        stats:
            List<BaseStat>.from(json["stats"].map((x) => BaseStat.fromJson(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        weight: json["weight"],
      );

  static double getBmi(int height, int weight) {
    return weight / (height * height);
  }

  static int getStat(List<BaseStat> stats, String statName) {
    return stats.firstWhere((s) => s.stat.name == statName).baseStat;
  }

  static double getAvgPower(List<BaseStat> stats) =>
      (getStat(stats, 'hp') +
          getStat(stats, 'attack') +
          getStat(stats, 'defense') +
          getStat(stats, 'special-attack') +
          getStat(stats, 'special-defense') +
          getStat(stats, 'speed')) /
      6;

  static BaseStatEntity getBaseStat(List<BaseStat> stats) => BaseStatEntity(
        attack: getStat(stats, 'attack'),
        avgPower: getAvgPower(stats),
        defense: getStat(stats, 'defense'),
        hp: getStat(stats, 'hp'),
        specialAttack: getStat(stats, 'special-attack'),
        specialDefense: getStat(stats, 'special-defense'),
        speed: getStat(stats, 'speed'),
      );

  PokemonDetailEntity convertToEntity() {
    return PokemonDetailEntity(
      baseStat: baseStat,
      bmi: bmi,
      height: height,
      imageUrl: imageUrl,
      id: id,
      isFavourite: isFavourite,
      name: name,
      speciesTypes: speciesTypes,
      weight: weight,
    );
  }
}

class Sprites {
  Sprites({
    this.other,
  });

  final Other? other;

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        other: json["other"] == null ? null : Other.fromJson(json["other"]),
      );
}

class Other {
  Other({
    this.officialArtwork,
  });

  final OfficialArtwork? officialArtwork;

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        officialArtwork: json["official-artwork"] == null
            ? null
            : OfficialArtwork.fromJson(json["official-artwork"]),
      );
}

class OfficialArtwork {
  OfficialArtwork({
    this.frontDefault,
  });

  final String? frontDefault;

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      OfficialArtwork(
        frontDefault: json["front_default"],
      );
}

class BaseStat {
  BaseStat({
    required this.baseStat,
    this.effort,
    required this.stat,
  });

  final int baseStat;
  final int? effort;
  final Detail stat;

  factory BaseStat.fromJson(Map<String, dynamic> json) => BaseStat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Detail.fromJson(json["stat"]),
      );
}

class Detail {
  final String name;
  final String url;

  Detail({
    required this.name,
    required this.url,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        name: json["name"],
        url: json["url"],
      );
}

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  final int slot;
  final Detail type;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Detail.fromJson(json["type"]),
      );
}
