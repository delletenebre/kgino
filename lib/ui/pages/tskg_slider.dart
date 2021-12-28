import 'package:flutter/material.dart';
import 'package:kgino/ui/slider_card.dart';

class TskgSlider extends StatelessWidget {
  const TskgSlider({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: [
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
          SliderCard(),
        ],
      )
    );
  }
}