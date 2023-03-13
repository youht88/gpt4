import 'package:flutter/material.dart';
//import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter_svg/parser.dart';
import 'package:get/get.dart';
import 'package:path_drawing/path_drawing.dart';

class SvgPage extends StatelessWidget {
  const SvgPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text("svg test",
                style: TextStyle(color: Theme.of(context).primaryColorDark))),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: 200,
                  height: 200,
                  color: Colors.black12,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        child: PathWidget(
                          color: Colors.red,
                          //fill: true,
                          svg:
                              "m15,0,l145,0,q30,0,30,30,v40,q0,30,-30,30,h-65,q-20,0,-40,-20,z",
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 100,
                        child: Image.asset("assets/images/boy.png"),
                      )
                    ],
                  )),
              Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: ShapeWidget(
                    svg: 'm50,50,l100,100,l100,-100,h-200',
                    child: Text(
                        "hello,I am a student \n and I hava a ball\n and I'm glade to meet you \n and I love to study dart!")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Image.network(
                          "http://youht.cc:18042/icfs/bafk43jqbea7m5wvdlgbpw4okcy7rzha52n2d3lo3tzglj7fvstkg7krbojhvc",
                          fit: BoxFit.cover
                          //width: 200,
                          //height: 100
                          ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     width: 200,
              //     height: 200,
              //     child: Cube(
              //       onSceneCreated: (Scene scene) {
              //         scene.world.add(Object(fileName: 'assets/obj/cube.obj'));
              //       },
              //     ),
              //   ),
              // )
            ],
          ),
        ));
  }
}

//生成一个由path指定图形的组件
// svg为符合svg规范的字符串
// child为这个svg所指定的shape图形内部显示的child

class ShapeWidget extends GetView {
  late Widget child;
  late String svg;
  double? width;
  double? height;
  ShapeWidget(
      {required this.svg, this.width, this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: ClipPath(
          clipper: _ShapeClipper(svg),
          child: child,
        ));
  }
}

class _ShapeClipper extends CustomClipper<Path> {
  String svg;
  _ShapeClipper(this.svg);
  @override
  Path getClip(Size size) {
    return parseSvgPathData(svg);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//生成一组由path指定的图形
// svg为符合svg规范的字符串或字符串数组
// color为对应svg个数的颜色数组，如果颜色个数小于svg个数，则后续的svg path采用最后一个颜色
// fill为是否填充，默认为不填充（如果为填充，而指定的svg的是一个非封闭图形则无法填充显示）
class PathWidget extends GetView {
  dynamic svg;
  dynamic color;
  bool? fill;
  Widget? child;
  PathWidget({required this.svg, required this.color, this.fill, this.child});
  @override
  Widget build(BuildContext context) {
    if (svg is! List) {
      svg = [svg];
    }
    if (color is! List) {
      color = [color];
    }
    List<Widget> widgets = [];
    for (int i = 0; i < svg.length; i++) {
      widgets.add(CustomPaint(
          painter: _PathPainter(
              svg: svg[i],
              color: i < color.length ? color[i] : color[i - 1],
              fill: fill)));
    }
    return Stack(children: widgets..add(child ?? SizedBox.shrink()));
  }
}

class _PathPainter extends CustomPainter {
  late Path path;
  final String svg;
  final Color color;
  bool? fill;

  _PathPainter({
    required this.svg,
    required this.color,
    this.fill,
  }) {
    path = parseSvgPathData(svg);
  }

  @override
  bool shouldRepaint(_PathPainter oldDelegate) =>
      oldDelegate.path != path || oldDelegate.color != color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      path,
      Paint()
        //..shader = LinearGradient(colors: [Colors.blue, color.withOpacity(0.2)])
        //    .createShader(Offset.zero & size)
        ..color = color
        //..shader = LinearGradient(colors: [color, color.withOpacity(0.5)])
        //    .createShader(Offset.zero & size)
        ..strokeWidth = 1.0
        ..style = (fill ?? false) ? PaintingStyle.fill : PaintingStyle.stroke,
    );
  }

  @override
  bool hitTest(Offset position) => path.contains(position);
}
