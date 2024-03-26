import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class TextForProfileCompletionWelcome extends StatelessWidget {
  const TextForProfileCompletionWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            L10n.welcomeText,
            style: TextStyle(
                color: ColorSet.of(context).text,
                fontWeight: FontWeightSet.normal,
                fontSize:
                    FontSizeSet.getFontSize(context, FontSizeSet.header1)),
          ),
        ],
      ),
    );
  }
}
