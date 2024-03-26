import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class EvaluationStarsWidget extends StatelessWidget {
  final int numOfSelectedStars;
  final void Function(int) onPressed;
  const EvaluationStarsWidget({
    super.key,
    required this.numOfSelectedStars,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    L10n.evaluationText,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                            context, FontSizeSet.header3),
                        color: ColorSet.of(context).greyText),
                  ),
                  Divider(
                    color: ColorSet.of(context).greyText,
                    thickness: 0.5,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(5, (index) {
            return InkWell(
              onTap: () {
                onPressed(index);
              },
              child: Icon(
                Icons.star,
                color: index < numOfSelectedStars
                    ? ColorSet.of(context).primary
                    : ColorSet.of(context).unselectedText,
                size: 50,
              ),
            );
          }),
        ),
      ],
    );
  }
}
