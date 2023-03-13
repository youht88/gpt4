import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuCheckBox extends StatelessWidget {
  NeuCheckBox(
      {required this.value,
      required this.onChanged,
      this.padding =
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      this.margin = const EdgeInsets.all(0),
      this.isEnabled = true,
      this.boxShape,
      this.selectedColor,
      this.disabledColor,
      this.lightSource,
      Key? key})
      : super(key: key);
  bool value;
  Function(dynamic) onChanged;
  EdgeInsets padding;
  EdgeInsets margin;
  bool isEnabled;
  Color? selectedColor;
  Color? disabledColor;
  LightSource? lightSource;
  NeumorphicBoxShape? boxShape;
  @override
  Widget build(BuildContext context) {
    return NeumorphicCheckbox(
        value: value,
        onChanged: onChanged,
        padding: padding,
        margin: margin,
        isEnabled: isEnabled,
        style: NeumorphicCheckboxStyle(
          lightSource: lightSource,
          boxShape: boxShape,
          selectedColor: selectedColor,
          disabledColor: disabledColor,
        ));
  }
}
