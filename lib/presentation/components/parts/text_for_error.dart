import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class TextForError extends StatelessWidget {
  const TextForError({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      L10n.errorText,
      style: TextStyle(
          //エラーテキストのカラーは赤が一般的、、？であればcolorsetに定義しておく？
          color: ColorSet.of(context).text,
          fontWeight: FontWeightSet.normal,
          fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body)),
    );
  }
}
