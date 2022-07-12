import 'package:medcare/Utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: amigo_white,
      body: Center(
        child: SpinKitPulse(
          color: amigo_blue,
          size: 100,
        ),
      ),
    );
  }
}
