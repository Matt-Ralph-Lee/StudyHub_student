import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/page_path.dart';

class TextButtonForNavigatingToEvaluationPage extends StatelessWidget {
  const TextButtonForNavigatingToEvaluationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void push(BuildContext context) {
      context.push(PageId.evaluationPage.path);
    }

    return TextButton(
      onPressed: () => push(context),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorSet.of(context).primary)),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
      ),
      child: Text(
        "この教師を評価する", //L10nで定義
        style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
            color: ColorSet.of(context).primary),
      ),
    );
  }
}
