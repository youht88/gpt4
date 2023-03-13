import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import 'neu.dart';

class NeuPage extends StatelessWidget {
  const NeuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NeuController controller = Get.put(NeuController());
    return GetBuilder<NeuController>(
      init: controller,
      builder: (_) => Scaffold(
          appBar: NeumorphicAppBar(
              leading: NeuButton("", iconData: Icons.arrow_back_ios_new,
                  onPressed: () {
                Get.back();
              },
                  shape: NeumorphicShape.concave,
                  boxShape: const NeumorphicBoxShape.circle()),
              automaticallyImplyLeading: true,
              title: NeuText("Neumorphic")),
          backgroundColor: NeumorphicTheme.baseColor(context),
          body: Stack(
            children: [
              // Container(
              //   width: Get.width,
              //   height: Get.height,
              //   child: Image.asset("assets/images/gradient.jpeg",
              //       fit: BoxFit.fill),
              // ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      NeuSwitch(
                          value: controller.switch1,
                          shape: NeumorphicShape.convex,
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey,
                          //size: 30,
                          onChanged: (bool isTrue) {
                            controller.switch1 = isTrue;
                            controller.update();
                          }),
                      SizedBox(height: 8),
                      NeuContainer(
                          width: 50,
                          height: 50,
                          lightSource: LightSource.topRight,
                          depth: 1,
                          boxShape: NeumorphicBoxShape.circle(),
                          shape: NeumorphicShape.concave,
                          child: Align(
                            alignment: Alignment(0.5, -0.5),
                            child: NeuContainer(
                              width: 5,
                              height: 5,
                              boxColor: Colors.green,
                              depth: -2,
                              boxShape: NeumorphicBoxShape.circle(),
                            ),
                          )),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NeuButton("theme", onPressed: () {
                              NeumorphicTheme.of(context)!.themeMode =
                                  NeumorphicTheme.isUsingDark(context)
                                      ? ThemeMode.light
                                      : ThemeMode.dark;
                            }),
                            NeuButton("",
                                //height: 100,
                                //width: 100,
                                iconData: Icons.face,
                                shape: NeumorphicShape.concave,
                                boxShape: const NeumorphicBoxShape.circle(),
                                onPressed: () {}),
                            NeuButton("kkk", onPressed: () async {
                              await Get.bottomSheet(NeuContainer(
                                  height: 100,
                                  child: NeuButton("hello world",
                                      iconData: Icons.ac_unit, onPressed: () {
                                    Get.back();
                                  })));
                            }),
                            NeuButton("马到成功",
                                iconData: Icons.accessible,
                                color: Colors.green,
                                depth: 2,
                                //size: 10,
                                lightSource: LightSource.top,
                                boxShape: const NeumorphicBoxShape.stadium(),
                                onPressed: () {}),
                            const SizedBox(height: 40),
                            NeuIcon(Icons.favorite,
                                size: 25,
                                //color: Colors.redAccent,
                                boxShape: const NeumorphicBoxShape.circle()),
                          ]),
                      const SizedBox(height: 40),
                      NeuTextField(
                        hintText: "输入文字",
                        //minLines: 2,
                        //maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        prefixIcon: Icon(Icons.ac_unit),
                        suffixIcon: Icon(Icons.lock),
                        onChanged: (item) {},
                        textEditingController: TextEditingController(),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 200,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                NeuIndicator(
                                    //padding: EdgeInsets.all(8),
                                    width: 100,
                                    height: 10,
                                    orientation: NeumorphicIndicatorOrientation
                                        .horizontal,
                                    color: Colors.purple,
                                    value: 0.7),
                                NeuIndicator(
                                    //padding: EdgeInsets.all(8),
                                    width: 15,
                                    height: 100,
                                    color: Colors.purple,
                                    value: 0.4),
                                NeuIndicator(
                                    //padding: EdgeInsets.all(8),
                                    width: 15,
                                    height: 100,
                                    color: Colors.purple,
                                    value: 0.2),
                              ],
                            )),
                      ),
                      NeuContainer(
                          boxShape: NeumorphicBoxShape.path(
                              NeuPathProvider(NeuPath.star)),
                          depth: -1,
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Center(child: Text("abcd")))),
                      SizedBox(
                        height: 40,
                        width: 300,
                        child: NeuSlider(
                            min: 0,
                            max: 10,
                            value: controller.sliderValue,
                            depth: -2,
                            thumb: NeuContainer(
                                child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: NeuIcon(Icons.accessibility),
                            )),
                            //size: 10,
                            color: Colors.red,
                            onChanged: (value) {
                              controller.sliderValue = value.toInt().toDouble();
                              controller.update();
                            }),
                      ),
                      NeuText("${controller.sliderValue}", depth: 0),
                      GestureDetector(
                        onTap: () async {
                          await controller.progress();
                        },
                        child: NeuProgress(
                            value: controller.progressValue,
                            size: 10,
                            color: Colors.green),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NeuContainer(
                          height: 200,
                          width: 200,
                          child: Center(
                              child: NeuToggle(
                            height: 40,
                            depth: -1,
                            //color: Colors.blue,
                            selectedIndex: controller.toggleIdx,
                            //thumb: Container(color: Colors.grey),
                            onChanged: (idx) {
                              controller.toggleIdx = idx;
                              controller.update();
                            },
                            children: [
                              ToggleElement(
                                  background: Center(
                                      child: NeuIcon(Icons.ac_unit,
                                          depth: 3,
                                          boxShape: const NeumorphicBoxShape
                                              .circle())),
                                  foreground: Center(child: Text("a"))),
                              ToggleElement(
                                  background: Center(child: Text("B")),
                                  foreground: Center(child: Text("b"))),
                              ToggleElement(
                                  background: Center(child: Text("C")),
                                  foreground: Center(child: Text("c")))
                            ],
                          )),
                        ),
                      ),
                      Container(
                        height: 250,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            NeuButton(
                              "T",
                              onPressed: () {},
                              width: 80,
                              height: 80,
                              depth: -1,
                              shape: NeumorphicShape.concave,
                              boxShape: NeumorphicBoxShape.path(
                                  NeuPathProvider(NeuPath.regularTriangle)),
                            ),
                            NeuButton(
                              "D",
                              onPressed: () {},
                              width: 80,
                              height: 80,
                              depth: -1,
                              shape: NeumorphicShape.concave,
                              boxShape: NeumorphicBoxShape.path(
                                  NeuPathProvider(NeuPath.diamond)),
                            ),
                            NeuButton(
                              "C",
                              onPressed: () {},
                              width: 80,
                              height: 80,
                              depth: 15,
                              shape: NeumorphicShape.convex,
                              boxShape: NeumorphicBoxShape.beveled(
                                  BorderRadius.circular(5)),
                            ),
                            NeuButton(
                              "V",
                              onPressed: () {},
                              width: 200,
                              height: 200,
                              //boxColor: Colors.red,
                              depth: 5,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.path(NeuPathProvider(
                                  NeuPath.svgPath,
                                  svgPath:
                                      "M100,100,L100,0,A100,100,0,0,1,200,100,M100,100,L100,200,A100,100,0,0,1,0,100")),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      NeuContainer(
                          width: 300,
                          child: Container(
                            //color: Colors.blue,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: NeuBarChart(
                                    color: Colors.tealAccent,
                                    values: [1, 3, 4, 2],
                                    labels: ["1. 1", '2.28', '3.20', '4.15'],
                                    height: 130,
                                    width: 140),
                              ),
                            ),
                          )),
                      const SizedBox(height: 40),
                      NeuRadio(
                          value: "ppp",
                          groupValue: controller.radioValue2,
                          onChanged: (value) {
                            if (value == null) return;
                            controller.radioValue2 = value as String;
                            controller.update();
                          },
                          child: NeuIcon(Icons.abc),
                          boxShape: NeumorphicBoxShape.circle()),
                      SizedBox(height: 8),
                      NeuRadio(
                          value: "qqq",
                          groupValue: controller.radioValue2,
                          onChanged: (value) {
                            if (value == null) return;
                            controller.radioValue2 = value as String;
                            controller.update();
                          },
                          child: NeuIcon(Icons.account_tree_rounded),
                          boxShape: NeumorphicBoxShape.circle()),
                      SizedBox(height: 10),
                      Container(
                        width: 200,
                        child: Row(
                          children: [
                            NeuRadio(
                                value: "clock",
                                groupValue: controller.radioValue1,
                                onChanged: (value) {
                                  if (value == null) return;
                                  controller.radioValue1 = value as String;
                                  controller.update();
                                },
                                child: NeuIcon(Icons.access_alarm),
                                boxShape: NeumorphicBoxShape.circle()),
                            SizedBox(width: 10),
                            NeuRadio(
                                value: "lib",
                                groupValue: controller.radioValue1,
                                child: NeuIcon(Icons.account_balance),
                                onChanged: (value) {
                                  if (value == null) return;
                                  controller.radioValue1 = value as String;
                                  controller.update();
                                },
                                boxShape: NeumorphicBoxShape.circle()),
                            SizedBox(width: 10),
                            NeuRadio(
                                value: "lock",
                                groupValue: controller.radioValue1,
                                child: NeuIcon(Icons.lock),
                                onChanged: (value) {
                                  if (value == null) return;
                                  controller.radioValue1 = value as String;
                                  controller.update();
                                },
                                boxShape: NeumorphicBoxShape.circle()),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        //height: 200,
                        child: Align(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NeuButton("kkk", onPressed: () {}),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(children: [
                              NeuCheckBox(
                                  value: controller.checkbox1,
                                  onChanged: (item) {
                                    controller.checkbox1 =
                                        !controller.checkbox1;
                                    controller.update();
                                  }),
                              const SizedBox(width: 10),
                              NeuText("china")
                            ]),
                            Row(children: [
                              NeuCheckBox(
                                  value: controller.checkbox2,
                                  onChanged: (item) {
                                    controller.checkbox2 =
                                        !controller.checkbox2;
                                    controller.update();
                                  }),
                              const SizedBox(width: 10),
                              NeuText("japan")
                            ]),
                            Row(children: [
                              NeuCheckBox(
                                value: controller.checkbox3,
                                onChanged: (item) {
                                  controller.checkbox3 = !controller.checkbox3;
                                  controller.update();
                                },
                                isEnabled: false,
                              ),
                              const SizedBox(width: 10),
                              NeuText("american")
                            ]),
                          ],
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, idx) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NeuTile(
                                  //depth: 3,
                                  //textColor: Colors.teal,
                                  iconColor: Colors.pinkAccent,
                                  shape: NeumorphicShape.convex,
                                  trailing: NeuIcon(Icons.lock,
                                      shape: NeumorphicShape.concave,
                                      boxShape: NeumorphicBoxShape.circle()),
                                  leading: Icon(Icons.ac_unit),
                                  title: Text("abc"),
                                  subtitle: Text("xyz")),
                            );
                          }),
                      const Divider(height: 15, color: Colors.teal),
                      Center(
                          child: NeuCard(
                              //depth: -1,
                              width: 300,
                              height: 200,
                              corner: 30,
                              //cornerColor: Colors.green,
                              cornerAlignment: BadgeAlignment.topLeft,
                              cornerTextSpan: const TextSpan(children: [
                                TextSpan(
                                    text: "99+", style: TextStyle(fontSize: 8))
                              ]),
                              bgIconData: Icons.ac_unit,
                              bgIconAlignment: const Alignment(0.5, 0.5),
                              bgSvgData: "m0,0,l50,50,h-50,0,z",
                              bgSvgAlignment: const Alignment(-0.5, -0.5),
                              child: Align(
                                  alignment: Alignment(0.8, -0.8),
                                  child: NeuContainer(
                                      shape: NeumorphicShape.concave,
                                      boxShape: NeumorphicBoxShape.path(
                                          NeuPathProvider(
                                              NeuPath.regularTriangle)),
                                      width: 100,
                                      height: 80))
                              // child: Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: NeuBarChart(
                              //       width: 280,
                              //       height: 120,
                              //       values: [1, 3.3, 5.8, 2, 7, 19, 8],
                              //       labels: ['日', '一', '二', '三', '四', '五', '六'],
                              //       color: Colors.green),
                              // ),
                              //boxShape: NeumorphicBoxShape.path(
                              //    NeuPathProvider(NeuPath.test))
                              )),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NeuContainer(
                          width: 100,
                          height: 100,
                          depth: 1,
                          //boxShape: NeumorphicBoxShape.circle(),
                          child: Center(
                              child: NeuContainer(
                            //boxShape: NeumorphicBoxShape.beveled(),
                            depth: -1,
                            width: 90,
                            height: 90,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NeuContainer(
                            width: 40,
                            height: 40,
                            depth: 1,
                            boxShape: NeumorphicBoxShape.circle(),
                            child: Center(
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/earth.jpeg',
                                      )),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
