import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class TextForResetPasswordEmailAddressInputExplanation extends StatelessWidget {
  const TextForResetPasswordEmailAddressInputExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.8,
      child: Column(
        children: [
          Text(
            L10n.passwordResetTitle,
            style: TextStyle(
                color: ColorSet.of(context).text,
                fontWeight: FontWeightSet.normal,
                fontSize:
                    FontSizeSet.getFontSize(context, FontSizeSet.header1)),
          ),
          const SizedBox(height: 20),
          Text(
            L10n.passwordResetMailAddressInputExplanationText,
            style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
                color: ColorSet.of(context).text),
          ),
        ],
      ),
    );
  }
}
