import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuSwitch extends StatelessWidget {
  NeuSwitch(
      {required this.value,
      required this.onChanged,
      this.shape = NeumorphicShape.convex,
      this.isEnabled = true,
      this.activeColor,
      this.inactiveColor,
      this.lightSource,
      this.size = 20,
      Key? key})
      : super(key: key);
  bool value;
  Function(bool) onChanged;
  NeumorphicShape shape;
  double size;
  bool isEnabled;
  Color? activeColor;
  Color? inactiveColor;
  LightSource? lightSource;
  @override
  Widget build(BuildContext context) {
    return NeumorphicSwitch(
        value: value,
        onChanged: onChanged,
        height: size,
        isEnabled: isEnabled,
        style: NeumorphicSwitchStyle(
            lightSource: lightSource,
            thumbShape: shape,
            activeTrackColor: activeColor,
            inactiveTrackColor: inactiveColor));
  }
}
