import 'package:flutter/widgets.dart';

class SizeConfig {
  static double? _screenWidth;
  static double? _screenHeight;
  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;
  static double? regulartextSize;
  static double? appBarTextSize;

  static double? textMultiplier;
  static double? heightMultiplier;
  static double? widthMultiplier;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
    }

    _blockSizeHorizontal = (_screenWidth! / 100);
    _blockSizeVertical = _screenHeight! / 100;

    textMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;
    widthMultiplier = _blockSizeHorizontal;
    regulartextSize = textMultiplier! * 4;
    appBarTextSize = textMultiplier! * 4;
  }

  static double getHeight(double height) {
    return (height / 7.32) * heightMultiplier!;
  }

  static double getWidth(double width) {
    return (width / 3.6) * widthMultiplier!;
  }

  static double getText(double textSize) {
    return (textSize / 7.32) * heightMultiplier!;
  }
}
