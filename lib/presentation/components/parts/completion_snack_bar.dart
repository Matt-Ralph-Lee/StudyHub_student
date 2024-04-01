import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

SnackBar completionSnackBar(BuildContext context, String content) {
  return SnackBar(
    backgroundColor: ColorSet.of(context).surface,
    content: Text(
      content,
      style: TextStyle(
          fontWeight: FontWeightSet.normal,
          fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
          color: ColorSet.of(context).text),
    ),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(
        color: ColorSet.of(context).primary,
        width: 1.0,
      ),
    ),
  );
}
