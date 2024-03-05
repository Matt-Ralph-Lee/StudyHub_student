import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class SectionHeader extends StatelessWidget {
  final String text;

  const SectionHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: ColorSet.of(context).text,
          fontWeight: FontWeightSet.normal,
          fontSize: FontSizeSet.body),
    );
  }
}
