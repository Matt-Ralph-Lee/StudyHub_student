import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

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
            Text(
              "評価する", //ここのテキストは要検討。右上のボタンが検討するなのにここも検討するなのはどうかと、、
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize:
                      FontSizeSet.getFontSize(context, FontSizeSet.header3),
                  color: ColorSet.of(context).primary),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 3,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            );
          }),
        ),
      ],
    );
  }
}
