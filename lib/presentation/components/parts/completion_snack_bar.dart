import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

SnackBar CompletionSnackBar(BuildContext context, String content) {
  return SnackBar(
    content: Text(
      content,
      style: TextStyle(
          fontWeight: FontWeightSet.normal,
          fontSize: FontSizeSet.body,
          color: ColorSet.of(context).text),
    ),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(20.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(
        color: ColorSet.of(context).primary,
        width: 2.0,
      ),
    ),
  );
}
