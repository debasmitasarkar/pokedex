import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/constants/color_constants.dart';
import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:pokedex/presentation/pages/pokemon_detail/pokemon_detail_controller.dart';
import 'package:pokedex/presentation/widgets/pokemon_detail_header.dart';
import 'package:pokedex/presentation/widgets/pokemon_shape_info.dart';
import 'package:pokedex/presentation/widgets/pokemon_stat_widget.dart';

class PokemonDetailScreen extends ConsumerStatefulWidget {
  final PokemonDetailEntity pokemonDetailEntity;
  const PokemonDetailScreen({
    Key? key,
    required this.pokemonDetailEntity,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends ConsumerState<PokemonDetailScreen> {
  @override
  void initState() {
    ref
        .read(pokemonDetailControllerProvider)
        .checkIffavourite(widget.pokemonDetailEntity.name.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          bool isFavourite = ref.watch(pokemonStateProvider);
          return FloatingActionButton.extended(
            label: Text(
              isFavourite ? 'Remove from favourites' : 'Mark as favourite',
              style: TextStyle(
                  color:
                      isFavourite ? ColorConstants.primaryBlue : Colors.white),
            ),
            backgroundColor: isFavourite
                ? ColorConstants.lightBlue
                : ColorConstants.primaryBlue,
            onPressed: () async {
              if (!isFavourite) {
                await ref
                    .read(pokemonDetailControllerProvider)
                    .markAsFavourite(widget.pokemonDetailEntity);
              } else {
                await ref
                    .read(pokemonDetailControllerProvider)
                    .removeFromFavourites(widget.pokemonDetailEntity);
              }
            },
          );
        },
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: const BackButton(color: ColorConstants.grey),
            pinned: true,
            backgroundColor: Colors.green[50],
            expandedHeight: 50,
            forceElevated: true,
            elevation: 2,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                PokemonDetailHeader(
                    pokemonDetailEntity: widget.pokemonDetailEntity),
                PokemonShapeInfo(
                    pokemonDetailEntity: widget.pokemonDetailEntity),
                PokemonStatWidget(
                  pokemonDetailEntity: widget.pokemonDetailEntity,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
