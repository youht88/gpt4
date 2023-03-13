import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import 'neu_container.dart';
import 'neu_text.dart';

class NeuBarChart extends StatelessWidget {
  NeuBarChart(
      {required this.values,
      this.labels,
      this.depth = -1,
      this.lightSource,
      required this.height,
      required this.width,
      this.padding = EdgeInsets.zero,
      this.orientation = NeumorphicIndicatorOrientation.vertical,
      this.color,
      Key? key})
      : super(key: key);
  List<double> values;
  List<String>? labels;
  double depth;
  double width;
  double height;
  EdgeInsets padding;
  NeumorphicIndicatorOrientation orientation;
  Color? color;
  LightSource? lightSource;
  @override
  Widget build(BuildContext context) {
    if (labels != null) {
      assert(labels!.length == values.length);
    }
    double maxValue = values.reduce((a, b) => max(a, b));
    int itemCount = values.length;
    int idx = 0;
    return Container(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: values.map((item) {
          idx += 1;
          double pad = 8.0;
          final barWidth = width / itemCount - 2 * pad;
          final barHeight = height - 2 * pad - barWidth;
          //(Get.context?.size?.width ?? 200) / itemCount - 2 * pad;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: pad),
            child: Column(
              children: [
                NeumorphicIndicator(
                    percent: item / maxValue,
                    orientation: orientation,
                    height: barHeight,
                    width: barWidth,
                    padding: padding,
                    style: IndicatorStyle(
                      depth: depth,
                      accent: color,
                      variant: color,
                      lightSource: lightSource,
                    )),
                const SizedBox(height: 2),
                labels != null
                    ? NeuText(labels![idx - 1],
                        size: (barWidth + pad * 2) / labels![idx - 1].length)
                    : const SizedBox.shrink()
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
