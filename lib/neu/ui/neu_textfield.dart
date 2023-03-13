import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../neu.dart';

class NeuTextField extends StatelessWidget {
  NeuTextField(
      {required this.onChanged,
      this.padding = const EdgeInsets.symmetric(horizontal: 10),
      this.margin = const EdgeInsets.all(0),
      this.boxShape,
      this.shape = NeumorphicShape.concave,
      this.depth = -1,
      this.lightSource,
      this.size = 16,
      this.hintText,
      this.color,
      this.minLines,
      this.maxLines,
      this.focusNode,
      this.keyboardType,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      required this.textEditingController,
      Key? key})
      : super(key: key);
  double size;
  Color? color;
  Function(dynamic) onChanged;
  EdgeInsets padding;
  EdgeInsets margin;
  double? depth;
  LightSource? lightSource;
  NeumorphicShape shape;
  NeumorphicBoxShape? boxShape;
  int? minLines;
  int? maxLines;
  String? hintText;
  FocusNode? focusNode;
  TextInputType? keyboardType;
  TextEditingController textEditingController;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return NeuContainer(
        //height: size,
        margin: margin,
        lightSource: lightSource,
        boxShape: boxShape,
        depth: depth,
        shape: shape,
        child: Padding(
          padding: padding,
          child: Center(
            child: TextField(
              onChanged: onChanged,
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                      color: color?.withAlpha(64) ??
                          _textColor(context).withAlpha(64)),
                  border: InputBorder.none,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon),
              minLines: minLines,
              maxLines: maxLines ?? 1,
              keyboardType: keyboardType,
              obscureText: obscureText,
              autofocus: false,
              style: TextStyle(color: color ?? _textColor(context)),
              cursorColor: color ?? _textColor(context),
            ),
          ),
        ));
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
