import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'chat/chat_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return NeumorphicApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: NeumorphicThemeData(
              baseColor: Color(0xf0e0e0e0), //Color(0xFFFFFFFF),
              lightSource: LightSource.topRight,
              depth: 1,
              intensity: 1,
              accentColor: Colors.pink.shade200,
              defaultTextColor: Colors.black),
          darkTheme: const NeumorphicThemeData(
              baseColor: Color(0xFF3E3E3E),
              lightSource: LightSource.topRight,
              intensity: 1,
              depth: 1,
              accentColor: Colors.blue,
              defaultTextColor: Colors.white),
          home: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'zero-gpt',
            theme: //FlexThemeData.light(scheme: FlexScheme.mandyRed),
                ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
              buttonTheme: const ButtonThemeData(buttonColor: Colors.blue),
              bottomSheetTheme:
                  const BottomSheetThemeData(backgroundColor: Colors.amber),
              backgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                  subtitle2: TextStyle(fontSize: 16.sp),
                  button: TextStyle(fontSize: 16.sp),
                  bodyText2: TextStyle(fontSize: 16.sp)),
            ),
            darkTheme: //FlexThemeData.dark(scheme: FlexScheme.mandyRed),
                ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.red,
              buttonTheme: const ButtonThemeData(buttonColor: Colors.red),
              bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: Colors.deepOrangeAccent),
              backgroundColor: Colors.black,
              scaffoldBackgroundColor: Colors.black,
              textTheme: TextTheme(
                  headline1: TextStyle(fontSize: 60.sp, color: Colors.red),
                  headline2: TextStyle(fontSize: 50.sp, color: Colors.red),
                  headline3: TextStyle(fontSize: 40.sp, color: Colors.red),
                  headline6: TextStyle(fontSize: 20.sp, color: Colors.red),
                  subtitle1: TextStyle(fontSize: 20.sp),
                  subtitle2: TextStyle(fontSize: 16.sp),
                  button: TextStyle(fontSize: 16.sp),
                  bodyText1: TextStyle(fontSize: 30.sp),
                  bodyText2: TextStyle(fontSize: 16.sp, color: Colors.green)),
            ),
            home: ChatPage(),
          ),
        );
      },
    );
  }
}
