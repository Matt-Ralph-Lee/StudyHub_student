import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class TextForNoEvaluationFound extends StatelessWidget {
  const TextForNoEvaluationFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "評価はまだありません",
      style: TextStyle(
          color: ColorSet.of(context).text,
          fontWeight: FontWeightSet.normal,
          fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body)),
    );
  }
}
