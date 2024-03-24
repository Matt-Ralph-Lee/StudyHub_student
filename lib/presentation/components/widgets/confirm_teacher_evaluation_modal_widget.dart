import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class ConfirmTeacherEvaluationModalWidget extends StatelessWidget {
  final int numOfEvaluationStars;
  final String evaluationText;
  const ConfirmTeacherEvaluationModalWidget({
    super.key,
    required this.numOfEvaluationStars,
    required this.evaluationText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorSet.of(context).surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 12), //textButtonが領域多めに取るのでバランス的にbottomだけ12px
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              L10n.confirmModalTitleText,
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize: FontSizeSet.body,
                  color: ColorSet.of(context).text),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: index < numOfEvaluationStars
                      ? ColorSet.of(context).primary
                      : ColorSet.of(context)
                          .inactiveGreySurface, // 指定された数までの星に色を付ける
                );
              }),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              evaluationText,
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize: FontSizeSet.body,
                  color: ColorSet.of(context).text),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text(
                    L10n.modalCancelText,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.body,
                        color: ColorSet.of(context).text),
                  ),
                  onPressed: () {
                    context.pop(false);
                  },
                ),
                TextButton(
                  child: Text(
                    L10n.modalOkText,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.body,
                        color: ColorSet.of(context).text),
                  ),
                  onPressed: () {
                    context.pop(true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
