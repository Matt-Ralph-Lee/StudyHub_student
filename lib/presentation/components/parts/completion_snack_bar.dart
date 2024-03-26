import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

SnackBar CompletionSnackBar(BuildContext context, String content) {
  return SnackBar(
    backgroundColor: ColorSet.of(context).greySurface,
    content: Text(
      content,
      style: TextStyle(
          fontWeight: FontWeightSet.normal,
          fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
          color: ColorSet.of(context).text),
    ),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).size.width < 600 ? 150 : 225), //ipadレスポンシブ
        right: 20,
        left: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(
        color: ColorSet.of(context).primary,
        width: 2.0,
      ),
    ),
  );
}
