import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuContainer extends StatelessWidget {
  NeuContainer({
    this.child,
    this.width,
    this.height,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.size,
    this.weight,
    this.color,
    this.boxColor,
    this.depth,
    this.lightSource,
    this.shape = NeumorphicShape.flat,
    this.boxShape,
  });
  Widget? child;
  double? width;
  double? height;
  EdgeInsets margin;
  EdgeInsets padding;
  double? size;
  FontWeight? weight;
  Color? color;
  Color? boxColor;
  double? depth;
  LightSource? lightSource;
  NeumorphicShape shape;
  NeumorphicBoxShape? boxShape;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Neumorphic(
        key: key,
        padding: padding,
        child: child,
        textStyle: TextStyle(
            color: color ?? _textColor(context),
            fontSize: size,
            fontWeight: weight),
        style: NeumorphicStyle(
          shape: shape,
          color: boxColor,
          depth: depth,
          lightSource:
              lightSource ?? NeumorphicTheme.currentTheme(context).lightSource,
          boxShape: boxShape ??
              NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
          //border: NeumorphicBorder(width: 0.03)
        ),
      ),
    );
  }

  Color _textColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (theme!.isUsingDark) {
      return theme.current!.defaultTextColor;
    } else {
      return theme.current!.defaultTextColor;
    }
  }
}
