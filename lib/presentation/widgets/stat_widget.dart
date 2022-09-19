import 'package:flutter/material.dart';
import 'package:pokedex/constants/color_constants.dart';
import 'package:pokedex/presentation/widgets/animated_slider.dart';

class StatWidget extends StatelessWidget {
  final String title;
  final int value;
  const StatWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: ColorConstants.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              value.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        AnimatedSlider(sliderValue: value),
        const SizedBox(height: 24),
      ],
    );
  }
}
