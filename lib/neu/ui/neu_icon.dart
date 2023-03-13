import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuIcon extends StatelessWidget {
  NeuIcon(this.iconData,
      {this.width,
      this.height,
      this.size = 20,
      this.color,
      this.depth,
      this.lightSource,
      this.shape = NeumorphicShape.flat,
      this.boxShape,
      Key? key})
      : super(key: key);
  IconData iconData;
  double? width;
  double? height;
  double size;
  Color? color;
  double? depth;
  LightSource? lightSource;
  NeumorphicShape shape;
  NeumorphicBoxShape? boxShape;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: key,
      width: width,
      height: height,
      child: NeumorphicIcon(
        iconData,
        size: size,
        style: NeumorphicStyle(
          shape: shape,
          color: color ?? _iconsColor(context),
          depth: depth,
          lightSource:
              lightSource ?? NeumorphicTheme.currentTheme(context).lightSource,
          boxShape: boxShape ??
              NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
          //border: NeumorphicBorder()
        ),
      ),
    );
  }

  Color? _iconsColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (theme!.isUsingDark) {
      return theme.current!.accentColor;
    } else {
      return theme.current!.defaultTextColor;
    }
  }
}
