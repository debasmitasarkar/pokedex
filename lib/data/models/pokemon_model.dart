import 'package:equatable/equatable.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';

// To parse this JSON data, do
//
//     final pokemonResponseModel = pokemonResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:pokedex/domain/entities/pokemon_response_entity.dart';

PokemonResponseModel pokemonResponseModelFromJson(String str) =>
    PokemonResponseModel.fromJson(json.decode(str));

String pokemonResponseModelToJson(PokemonResponseModel data) =>
    json.encode(data.toJson());

class PokemonResponseModel extends PokemonResponseEntity {
  const PokemonResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.pokemonModels,
  }) : super(next: next, pokemons: pokemonModels);

  final int count;
  final String? next;
  final dynamic previous;
  final List<PokemonModel> pokemonModels;

  factory PokemonResponseModel.fromJson(Map<String, dynamic> json) =>
      PokemonResponseModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        pokemonModels: List<PokemonModel>.from(
            json["results"].map((x) => PokemonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(pokemonModels.map((x) => x.toJson())),
      };
}

class PokemonModel extends PokemonEntity {
  final String name;
  final String url;

  const PokemonModel({
    required this.name,
    required this.url,
  }) : super(
          name: name,
          url: url,
        );

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
