import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuIndicator extends StatelessWidget {
  NeuIndicator(
      {this.value = 0.5,
      this.depth = -1,
      this.lightSource,
      this.height = 100,
      this.width = 15,
      this.padding = EdgeInsets.zero,
      this.orientation = NeumorphicIndicatorOrientation.vertical,
      this.color,
      Key? key})
      : super(key: key);
  double value;
  double depth;
  double width;
  double height;
  EdgeInsets padding;
  NeumorphicIndicatorOrientation orientation;
  Color? color;
  LightSource? lightSource;
  @override
  Widget build(BuildContext context) {
    return NeumorphicIndicator(
        percent: value,
        orientation: orientation,
        height: height,
        width: width,
        padding: padding,
        style: IndicatorStyle(
          depth: depth,
          accent: color,
          variant: color,
          lightSource: lightSource,
        ));
  }
}
