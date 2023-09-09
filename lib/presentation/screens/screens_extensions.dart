import 'package:flutter/material.dart';

extension ScreenExtension on BuildContext {
  double screenWidth() {
    return MediaQuery.of(this).size.width;
  }

  double screenHeight() {
    return MediaQuery.of(this).size.height;
  }

  double screenWidthUnit() {
    return MediaQuery.of(this).size.width / 100;
  }

  double screenHeightUnit() {
    return MediaQuery.of(this).size.height / 100;
  }
}
