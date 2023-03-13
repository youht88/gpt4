import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuRadio extends StatelessWidget {
  NeuRadio(
      {this.value,
      this.groupValue,
      this.child,
      required this.onChanged,
      this.padding = const EdgeInsets.all(8),
      this.isEnabled = true,
      this.boxShape,
      this.selectedColor,
      this.unselectedColor,
      this.lightSource,
      Key? key})
      : super(key: key);
  Object? value;
  Object? groupValue;
  Widget? child;
  Function(Object?)? onChanged;
  EdgeInsets padding;
  bool isEnabled;
  Color? selectedColor;
  Color? unselectedColor;
  LightSource? lightSource;
  NeumorphicBoxShape? boxShape;
  @override
  Widget build(BuildContext context) {
    return NeumorphicRadio(
        child: child,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        padding: padding,
        isEnabled: isEnabled,
        style: NeumorphicRadioStyle(
          lightSource: lightSource,
          boxShape: boxShape,
          selectedColor: selectedColor,
          unselectedColor: unselectedColor,
        ));
  }
}
