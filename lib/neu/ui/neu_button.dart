import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuButton extends StatelessWidget {
  NeuButton(this.text,
      {required this.onPressed,
      this.width,
      this.height,
      this.iconData,
      this.color,
      this.size,
      this.boxColor,
      this.depth,
      this.lightSource,
      this.shape = NeumorphicShape.flat,
      this.boxShape,
      Key? key})
      : super(key: key);
  String text;
  IconData? iconData;
  double? width;
  double? height;
  Color? color;
  double? size;
  Color? boxColor;
  double? depth;
  LightSource? lightSource;
  NeumorphicShape shape;
  NeumorphicBoxShape? boxShape;
  Function() onPressed;
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (iconData != null) {
      children.add(Icon(iconData,
          color: (color?.withOpacity(0.7) ?? _iconsColor(context)),
          size: size));
    }
    if (text != "") {
      children.add(Text(text,
          style:
              TextStyle(fontSize: size, color: color ?? _textColor(context))));
    }
    return SizedBox(
      width: width,
      height: height,
      child: NeumorphicButton(
        margin: const EdgeInsets.only(top: 12),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center, children: children),
        onPressed: onPressed,
        style: NeumorphicStyle(
          color: boxColor,
          // shadowLightColor: boxColor,
          // shadowLightColorEmboss: boxColor,
          // intensity: 0.8,
          // surfaceIntensity: 0.7,
          depth: depth,
          lightSource:
              lightSource ?? NeumorphicTheme.currentTheme(context).lightSource,
          shape: shape,
          boxShape: boxShape ??
              NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
          //border: NeumorphicBorder()
        ),
        padding: const EdgeInsets.all(12.0),
      ),
    );
  }

  Color _boxColor(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color _textColor(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color? _iconsColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (theme!.isUsingDark) {
      return theme.current!.accentColor;
    } else {
      return null;
    }
  }
}
