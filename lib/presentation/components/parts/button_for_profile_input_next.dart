import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';

class ButtonForProfileInputNext extends HookWidget {
  final VoidCallback? incrementCounter;

  const ButtonForProfileInputNext({
    Key? key,
    required this.incrementCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.25,
      child: ElevatedButton(
        onPressed: incrementCounter,
        style: ElevatedButton.styleFrom(
          foregroundColor: ColorSet.of(context).whiteText,
          disabledForegroundColor: ColorSet.of(context).unselectedText,
          backgroundColor: ColorSet.of(context).primary,
          disabledBackgroundColor: ColorSet.of(context).inactiveGreySurface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          padding: EdgeInsets.symmetric(
              vertical: PaddingSet.getPaddingSize(
            context,
            PaddingSet.elevatedButtonPadding,
          )),
        ),
        child: Text(
          L10n.nextButtonText,
          style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(
              context,
              FontSizeSet.annotation,
            ),
          ),
        ),
      ),
    );
  }
}
