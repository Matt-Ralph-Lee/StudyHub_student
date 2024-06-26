import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../parts/text_form_field_for_evaluation_input.dart';

class EvaluationTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const EvaluationTextFieldWidget(
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
            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    L10n.evaluationContentText,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                            context, FontSizeSet.annotation),
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
          height: 18,
        ),
        TextFormFieldForEvaluationInput(
          controller: controller,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
