import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PokemonShimmerWidget extends StatelessWidget {
  const PokemonShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        color: Colors.grey[200],
        height: 186,
        width: (MediaQuery.of(context).size.width - 40) / 3,
      ),
    );
  }
}
