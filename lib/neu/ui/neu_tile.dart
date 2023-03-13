import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'neu_container.dart';

class NeuTile extends StatelessWidget {
  NeuTile(
      {this.width,
      this.height,
      this.boxColor,
      this.depth,
      this.lightSource,
      this.shape = NeumorphicShape.flat,
      this.boxShape,
      this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.iconColor,
      this.textColor,
      this.tileColor,
      this.onTap,
      Key? key})
      : super(key: key);
  double? width;
  double? height;
  Color? boxColor;
  double? depth;
  LightSource? lightSource;
  NeumorphicShape shape;
  NeumorphicBoxShape? boxShape;
  Widget? leading;
  Widget? title;
  Widget? subtitle;
  Widget? trailing;
  Color? iconColor;
  Color? textColor;
  Color? tileColor;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return NeuContainer(
      width: width,
      height: height,
      color: boxColor,
      depth: depth,
      lightSource:
          lightSource ?? NeumorphicTheme.currentTheme(context).lightSource,
      shape: shape,
      boxShape:
          boxShape ?? NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
      //border: NeumorphicBorder()
      child: ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          iconColor: iconColor,
          textColor: textColor,
          tileColor: tileColor,
          onTap: onTap),
    );
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
