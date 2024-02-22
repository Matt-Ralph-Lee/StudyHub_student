import 'package:flutter/material.dart';

class FontSizeSet {
  static const double header1 = 24.0;
  static const double header2 = 20.0;
  static const double header3 = 16.0;
  static const double body = 14.0;
  static const double annotation = 12.0;

  static double getFontSize(BuildContext context, double size) {
    double width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return size;
    } else {
      return size * 1.5;
    }
  }
}
