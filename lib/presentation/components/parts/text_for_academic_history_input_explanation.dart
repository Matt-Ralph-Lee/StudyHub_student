import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class TextForAcademicHistoryInputExplanation extends StatelessWidget {
  const TextForAcademicHistoryInputExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.8,
      child: Text(
        L10n.academicHistoryInputExplanationText,
        style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.body,
            color: ColorSet.of(context).text),
      ),
    );
  }
}
