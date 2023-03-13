import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:path_drawing/path_drawing.dart';

enum NeuPath {
  diamond,
  semiBox,
  regularTriangle,
  leftBottomTriangle,
  rightBottomTriangle,
  test,
  semiCircle,
  svgPath,
  star
}

class NeuPathProvider extends NeumorphicPathProvider {
  NeuPathProvider(this.type, {this.svgPath = ""});
  NeuPath type;
  String svgPath;
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    switch (type) {
      case NeuPath.svgPath:
        if (svgPath != "") {
          return parseSvgPathData(svgPath);
        } else {
          return Path();
        }
      case NeuPath.semiCircle:
        return Path()
          ..moveTo(size.width / 2, size.height / 2)
          ..arcTo(
              Rect.fromCircle(
                  center: Offset(size.width / 2, size.height / 2), radius: 40),
              0,
              pi,
              false);
      case NeuPath.test:
        return Path()
          ..moveTo(0, 0)
          ..lineTo(size.width / 2, 0)
          ..lineTo(size.width / 2, size.height / 2)
          ..lineTo(0, size.height / 2)
          ..close()
          ..moveTo(size.width / 2, size.height / 2)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(size.width, size.height)
          ..lineTo(size.width / 2, size.height)
          ..close();
      case NeuPath.regularTriangle:
        double corner = min(size.width, size.height) * 0.1;
        double ang = atan2(2 * size.height, size.width);

        return Path()
          ..moveTo(corner, size.height)
          ..lineTo(size.width - corner, size.height)
          ..quadraticBezierTo(size.width, size.height,
              size.width - corner * cos(ang), size.height - corner * sin(ang))
          ..lineTo(size.width / 2 + corner * cos(ang), corner * sin(ang))
          ..quadraticBezierTo(
              size.width / 2,
              0,
              size.width / 2 - corner * cos(pi / 2 - ang),
              corner * sin(pi / 2 - ang))
          ..lineTo(corner * cos(ang), size.height - corner * sin(ang))
          ..quadraticBezierTo(0, size.height, corner, size.height)
          ..close();
      case NeuPath.diamond:
        return Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(size.width / 2, size.height)
          ..lineTo(0, size.height / 2)
          ..close();
      case NeuPath.semiBox:
        double corner = size.width * 0.1;
        double factor = 0.33;
        return Path()
          ..moveTo(0, size.height * factor)
          ..lineTo(0, size.height - corner)
          ..quadraticBezierTo(0, size.height, corner, size.height)
          ..lineTo(size.width - corner, size.height)
          ..quadraticBezierTo(
              size.width, size.height, size.width, size.height - corner)
          ..lineTo(size.width, corner * 2)
          ..quadraticBezierTo(
              size.width, 0, size.width - 3 * corner, corner * 2 - 12)
          ..lineTo(corner, size.height * factor + 10)
          ..quadraticBezierTo(0, size.height * factor + corner, 0,
              size.height * factor + corner * 2)
          ..close();
      case NeuPath.star:
        double degToRad(double deg) => deg * (pi / 180.0);
        const numberOfPoints = 5;
        final halfWidth = size.width / 2;
        final externalRadius = halfWidth;
        final internalRadius = halfWidth / 2.5;
        final degreesPerStep = degToRad(360 / numberOfPoints);
        final halfDegreesPerStep = degreesPerStep / 2;
        final path = Path();
        final fullAngle = degToRad(360);
        path.moveTo(size.width, halfWidth);

        for (double step = 0; step < fullAngle; step += degreesPerStep) {
          path.lineTo(halfWidth + externalRadius * cos(step),
              halfWidth + externalRadius * sin(step));
          path.lineTo(
              halfWidth + internalRadius * cos(step + halfDegreesPerStep),
              halfWidth + internalRadius * sin(step + halfDegreesPerStep));
        }
        path.close();
        return path;
      default:
        return Path();
    }
  }

  @override
  // TODO: implement oneGradientPerPath
  bool get oneGradientPerPath => false;
}
