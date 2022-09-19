import 'package:flutter/material.dart';
import 'package:pokedex/constants/color_constants.dart';
import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';

class PokemonShapeInfo extends StatelessWidget {
  final PokemonDetailEntity pokemonDetailEntity;
  const PokemonShapeInfo({
    Key? key,
    required this.pokemonDetailEntity,
  }) : super(key: key);

  Widget _getLayout(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: const TextStyle(
                color: ColorConstants.grey, fontSize: 12, height: 2),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.black, fontSize: 12),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 4,
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 1))
        ],
      ),
      child: Row(
        children: [
          _getLayout('Height', pokemonDetailEntity.height.toString()),
          _getLayout('Weight', pokemonDetailEntity.weight.toString()),
          _getLayout('BMI', pokemonDetailEntity.bmi.toStringAsFixed(1)),
        ],
      ),
    );
  }
}
