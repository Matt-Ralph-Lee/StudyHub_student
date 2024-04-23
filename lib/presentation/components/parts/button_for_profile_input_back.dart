import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class ButtonForProfileInputBack extends HookWidget {
  final VoidCallback? decrementCounter;

  const ButtonForProfileInputBack({
    Key? key,
    required this.decrementCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.25,
      child: TextButton(
        onPressed: decrementCounter,
        child: Text(
          L10n.backButtonText,
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(
                context,
                FontSizeSet.annotation,
              ),
              color: ColorSet.of(context).primary),
        ),
      ),
    );
  }
}
