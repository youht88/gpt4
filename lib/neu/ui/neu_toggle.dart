import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuToggle extends StatelessWidget {
  NeuToggle(
      {this.thumb = const SizedBox(),
      required this.children,
      this.selectedIndex = 0,
      required this.onChanged,
      this.padding = const EdgeInsets.all(2),
      this.isEnabled = true,
      this.lightSource,
      this.height = 20,
      this.width,
      this.depth,
      this.color,
      Key? key})
      : super(key: key);
  List<ToggleElement> children;
  Widget thumb;
  int selectedIndex;
  Function(int) onChanged;
  EdgeInsets padding;
  double height;
  double? width;
  double? depth;
  Color? color;
  bool isEnabled;
  LightSource? lightSource;
  @override
  Widget build(BuildContext context) {
    return NeumorphicToggle(
        children: children,
        thumb: thumb,
        padding: padding,
        selectedIndex: selectedIndex,
        onChanged: onChanged,
        height: height,
        width: width,
        isEnabled: isEnabled,
        style: NeumorphicToggleStyle(
          backgroundColor: color,
          depth: depth,
          lightSource: lightSource,
        ));
  }
}
