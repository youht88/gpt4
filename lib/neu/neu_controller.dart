import 'package:get/get.dart';

class NeuController extends GetxController {
  bool checkbox1 = true;
  bool checkbox2 = false;
  bool checkbox3 = true;
  String radioValue1 = "lib";
  String radioValue2 = "ppp";
  bool switch1 = true;
  double sliderValue = 0;
  double progressValue = 0;
  int toggleIdx = 0;
  progress() async {
    progressValue = 0;
    update();
    await Future.delayed(const Duration(seconds: 3), () {
      progressValue += 0.3;
      update();
    });
    await Future.delayed(const Duration(seconds: 2), () {
      progressValue += 0.3;
      update();
    });
    await Future.delayed(const Duration(seconds: 1), () {
      progressValue += 0.3;
      update();
    });
    progressValue = 1;
    update();
  }
}
