import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class TextButtonForUnFollowTeacher extends StatelessWidget {
  final VoidCallback onPressed;

  const TextButtonForUnFollowTeacher({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: ColorSet.of(context).primary,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
      ),
      child: Text(
        L10n.unFollowButtonText,
        style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.annotation),
            color: ColorSet.of(context).whiteText),
      ),
    );
  }
}
