import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuText extends StatelessWidget {
  NeuText(this.text,
      {this.size = 16,
      this.weight,
      this.color,
      this.depth,
      this.lightSource,
      this.shape = NeumorphicShape.flat,
      this.boxShape,
      Key? key})
      : super(key: key);
  String text;
  double size;
  FontWeight? weight;
  Color? color;
  double? depth;
  LightSource? lightSource;
  NeumorphicShape shape;
  NeumorphicBoxShape? boxShape;
  @override
  Widget build(BuildContext context) {
    return NeumorphicText(
      text,
      key: key,
      textStyle: NeumorphicTextStyle(fontSize: size, fontWeight: weight),
      style: NeumorphicStyle(
        shape: shape,
        color: color ?? _textColor(context),
        depth: depth,
        lightSource:
            lightSource ?? NeumorphicTheme.currentTheme(context).lightSource,
        boxShape:
            boxShape ?? NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
        //border: NeumorphicBorder()
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
