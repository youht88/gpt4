import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'neu_container.dart';
import 'neu_icon.dart';

class NeuSlider extends StatelessWidget {
  NeuSlider(
      {this.min = 0,
      this.value = 50,
      this.max = 100,
      this.depth = -1,
      this.onChanged,
      this.lightSource,
      this.size = 15,
      this.thumb,
      this.color,
      Key? key})
      : super(key: key);
  double min;
  double max;
  double value;
  double depth;
  Widget? thumb;
  Function(double)? onChanged;
  double size;
  Color? color;
  LightSource? lightSource;
  @override
  Widget build(BuildContext context) {
    return NeumorphicSlider(
        thumb: thumb,
        value: value,
        min: min,
        max: max,
        onChanged: onChanged,
        height: size,
        style: SliderStyle(
          depth: depth,
          accent: color,
          variant: color,
          lightSource: lightSource,
        ));
  }
}
