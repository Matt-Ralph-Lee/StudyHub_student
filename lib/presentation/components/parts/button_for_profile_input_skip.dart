import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class ButtonForProfileInputSkip extends HookWidget {
  final VoidCallback? skipCounter;

  const ButtonForProfileInputSkip({
    Key? key,
    required this.skipCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.25,
      child: TextButton(
        onPressed: skipCounter,
        child: Text(
          L10n.skipButtonText,
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize:
                  FontSizeSet.getFontSize(context, FontSizeSet.annotation),
              color: ColorSet.of(context).primary),
        ),
      ),
    );
  }
}
