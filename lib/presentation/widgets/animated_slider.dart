import 'package:flutter/material.dart';
import 'package:pokedex/constants/color_constants.dart';

class AnimatedSlider extends StatefulWidget {
  final int sliderValue;
  const AnimatedSlider({
    Key? key,
    required this.sliderValue,
  }) : super(key: key);

  @override
  State<AnimatedSlider> createState() => _AnimatedSliderState();
}

class _AnimatedSliderState extends State<AnimatedSlider>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  double sliderValue = 0;
  _getColor() {
    if (widget.sliderValue <= 30) {
      return const Color(0XFFCD2873);
    } else if (widget.sliderValue <= 60) {
      return const Color(0XFFEEC218);
    } else {
      return Colors.green;
    }
  }

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(
            begin: 0,
            end: widget.sliderValue.toDouble() > 100
                ? 100
                : widget.sliderValue.toDouble())
        .animate(controller);

    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, snapshot) {
        return SizedBox(
          width: MediaQuery.of(context).size.width - 32,
          child: Slider(
            min: 0.0,
            max: 100.0,
            activeColor: _getColor(),
            inactiveColor: ColorConstants.lightGrey,
            value: animation.value,
            onChanged: (double value) {},
          ),
        );
      },
    );
  }
}
