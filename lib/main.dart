// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medcare/home.dart';
import 'package:medcare/Screens/Auth/loginScreen.dart';
import 'package:medcare/routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'Utils/size_config.dart';
import 'globalvariable.dart';
import 'wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              navigatorKey: GlobalVariable.navState,
              title: 'Amigo',
              debugShowCheckedModeBanner: false,
              home: Wrapper(
                index: 0,
              ),
            );
          },
        );
      },
    );
  }
}
