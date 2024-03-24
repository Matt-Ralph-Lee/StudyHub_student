import 'package:flutter/material.dart';

class PaddingSet {
  static const double elevatedButtonPadding = 25.0;
  static const double horizontalPadding = 20;

  static double getPaddingSize(BuildContext context, double size) {
    double width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return size;
    } else {
      return size * 1.5;
    }
  }
}
