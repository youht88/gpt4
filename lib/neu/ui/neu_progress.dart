import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuProgress extends StatelessWidget {
  NeuProgress(
      {this.value = 0.5,
      this.depth = 1,
      this.lightSource,
      this.size = 15,
      this.color,
      Key? key})
      : super(key: key);
  double value;
  double depth;
  double size;
  Color? color;
  LightSource? lightSource;
  @override
  Widget build(BuildContext context) {
    return NeumorphicProgress(
        percent: value,
        height: size,
        style: ProgressStyle(
          depth: depth,
          accent: color,
          variant: color,
          lightSource: lightSource,
        ));
  }
}
