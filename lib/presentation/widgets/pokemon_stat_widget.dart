import 'package:flutter/material.dart';
import 'package:pokedex/constants/color_constants.dart';
import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:pokedex/presentation/widgets/stat_widget.dart';

class PokemonStatWidget extends StatelessWidget {
  final PokemonDetailEntity pokemonDetailEntity;
  const PokemonStatWidget({
    Key? key,
    required this.pokemonDetailEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: ColorConstants.lightGrey,
                  width: 1,
                ),
              ),
            ),
            child: const Text(
              'Base stats',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                StatWidget(
                  title: 'Hp',
                  value: pokemonDetailEntity.baseStat.hp,
                ),
                StatWidget(
                  title: 'Hp',
                  value: pokemonDetailEntity.baseStat.hp,
                ),
                StatWidget(
                  title: 'Attack',
                  value: pokemonDetailEntity.baseStat.attack,
                ),
                StatWidget(
                  title: 'Defense',
                  value: pokemonDetailEntity.baseStat.defense,
                ),
                StatWidget(
                  title: 'Special Attack',
                  value: pokemonDetailEntity.baseStat.specialAttack,
                ),
                StatWidget(
                  title: 'Special Defense',
                  value: pokemonDetailEntity.baseStat.specialDefense,
                ),
                StatWidget(
                  title: 'Speed',
                  value: pokemonDetailEntity.baseStat.speed,
                ),
                StatWidget(
                  title: 'Avg. Power',
                  value: pokemonDetailEntity.baseStat.avgPower.toInt(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
