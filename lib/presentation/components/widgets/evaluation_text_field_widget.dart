import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../parts/text_form_field_for_evaluation_input.dart';

class EvaluationTextWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const EvaluationTextWidget(
      {super.key, required this.controller, required this.onChanged});

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
              "コメントする",
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
        TextFormFieldForEvaluationInput(
          controller: controller,
          onChanged: onChanged,
        ),
      ],
    );
  }
}