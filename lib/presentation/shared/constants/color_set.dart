import 'package:flutter/material.dart';

abstract class ColorSchemeBase {
  late Color primary;
  late Color background;

  late Color surface;
  late Color greySurface;
  late Color inactiveGreySurface;

  late Color text;
  late Color greyText;
  late Color unselectedText;

  late Color icon;

  late Color cardShadow;

  late Color navbarIndicator;

  final blackBackground = const Color(0xff111111);
  final whiteText = const Color(0xffFFFFFF);
  final lightGreyIcon = const Color(0xffF7F7F7);
  final darkGreyIcon = const Color(0xff6C6C6C);
  final questionIcon = const Color(0xff74B4FF);
  final answerIcon = const Color(0xffFF7979);
}

class _LightColor extends ColorSchemeBase {
  static final _LightColor _cache = _LightColor.internal();

  _LightColor.internal();

  factory _LightColor() {
    return _cache;
  }

  @override
  Color get primary => const Color(0xff4B1015);
  @override
  Color get background => const Color(0xffFFFFFE);

  @override
  Color get surface => const Color(0xffFEFEFE);
  @override
  Color get greySurface => const Color(0xffEDEDED);
  @override
  Color get inactiveGreySurface => const Color(0xffA9A9A9);

  @override
  Color get text => const Color(0xff111111);
  @override
  Color get greyText => const Color(0xff5D5D5D);
  @override
  Color get unselectedText => const Color(0xffD2D2D2);

  @override
  Color get icon => const Color(0xff111111);

  @override
  Color get cardShadow => const Color(0x40ADADAD);

  @override
  Color get navbarIndicator => const Color(0xffF2D4D4);
}

class _DarkColor extends ColorSchemeBase {
  static final _DarkColor _cache = _DarkColor.internal();

  _DarkColor.internal();

  factory _DarkColor() {
    return _cache;
  }

  @override
  Color get primary => const Color(0xff974141);
  @override
  Color get background => const Color(0xff131313);

  @override
  Color get surface => const Color(0xff262626);
  @override
  Color get greySurface => const Color(0xff373737);
  @override
  Color get inactiveGreySurface => const Color(0xff2A2A2A);

  @override
  Color get text => const Color(0xffFFFFFF);
  @override
  Color get greyText => const Color(0xffAFAFAF);
  @override
  Color get unselectedText => const Color(0xff333333);

  @override
  Color get icon => const Color(0xffEEEEEE);

  @override
  Color get cardShadow => const Color(0x40434343);

  @override
  Color get navbarIndicator => const Color(0xff774E4E);
}

class ColorSet {
  static ColorSchemeBase of(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.light
        ? _LightColor()
        : _DarkColor();
  }
}
