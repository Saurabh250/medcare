import 'package:flutter/widgets.dart';

class SizeConfig {
  late double _screenWidth;
  late double _screenHeight;
  late double _blockSizeHorizontal = 0;
  late double _blockSizeVertical = 0;
  late double regulartextSize;
  late double appBarTextSize;
  late double textMultiplier;
  late double heightMultiplier;
  late double widthMultiplier;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
    }

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    textMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;
    widthMultiplier = _blockSizeHorizontal;
    regulartextSize = textMultiplier * 4;
    appBarTextSize = textMultiplier * 4;
  }

  // TODO: Change the 7.32 to your test device SizeConfig.heightMultiplier
  double getHeight(double height) {
    return (height / 7.32) * heightMultiplier;
  }

  // TODO: Change the 3.6 to your test device SizeConfig.widthMultiplier
  double getWidth(double width) {
    return (width / 3.6) * widthMultiplier;
  }

  // TODO: Change the 7.32 to your test device SizeConfig.textMultiplier
  double getText(double textSize) {
    return (textSize / 7.32) * heightMultiplier;
  }
}
