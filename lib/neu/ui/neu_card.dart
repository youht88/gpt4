import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:glass/glass.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import '../../svg/svg_page.dart';
import 'neu_container.dart';

class NeuCard extends StatelessWidget {
  NeuCard(
      {this.width,
      this.height,
      this.boxColor,
      this.depth,
      this.corner,
      this.cornerTextSpan,
      this.cornerColor,
      this.cornerAlignment = BadgeAlignment.topRight,
      this.bgIconData,
      this.bgIconAlignment = Alignment.topRight,
      this.bgSvgData,
      this.bgSvgAlignment = Alignment.topRight,
      this.child,
      this.lightSource,
      this.shape = NeumorphicShape.flat,
      this.boxShape,
      this.onTap,
      Key? key})
      : super(key: key);
  double? width;
  double? height;
  double? corner;
  Color? cornerColor;
  TextSpan? cornerTextSpan;
  BadgeAlignment cornerAlignment;
  IconData? bgIconData;
  Alignment bgIconAlignment;
  String? bgSvgData;
  Alignment bgSvgAlignment;
  Widget? child;
  Color? boxColor;
  double? depth;
  LightSource? lightSource;
  NeumorphicShape shape;
  NeumorphicBoxShape? boxShape;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: corner != null
          ? RotatedCornerDecoration(
              color: cornerColor ?? _iconsColor(context),
              textSpan: cornerTextSpan,
              geometry: BadgeGeometry(
                width: corner!,
                height: corner!,
                alignment: cornerAlignment,
              ))
          : null,
      child: NeuContainer(
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
        child: Stack(
          children: [
            bgIconData != null
                ? Align(
                    alignment: bgIconAlignment,
                    child: Icon(bgIconData,
                        size: height! / 3 * 2,
                        color: NeumorphicTheme.of(context)!
                            .current!
                            .disabledColor
                            .withAlpha(32)))
                : const SizedBox.shrink(),
            bgSvgData != null
                ? Align(
                    alignment: bgSvgAlignment,
                    child: PathWidget(
                        svg: bgSvgData,
                        color: NeumorphicTheme.of(context)!
                            .current!
                            .disabledColor
                            .withAlpha(64),
                        child: Container(height: 50, width: 50)))
                : const SizedBox.shrink(),
            Positioned(
                child: Padding(
              padding: EdgeInsets.only(top: corner ?? 0),
              child: child ?? const SizedBox.shrink(),
            ))
          ],
        ),
      ),
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
      return theme.current!.accentColor;
    }
  }
}
