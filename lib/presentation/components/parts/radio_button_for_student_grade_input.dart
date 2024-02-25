import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:studyhub/domain/student/models/grade.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class RadioButtonForStudentGradeInput extends HookWidget {
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  RadioButtonForStudentGradeInput({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  final studentGradeOptions = Grade.values.map((e) => e.japanese).toList();

  List<Widget> buildRadioButtons(BuildContext context) {
    return studentGradeOptions.map((option) {
      return GestureDetector(
        onTap: () => onChanged(option),
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: ColorSet.of(context).inactiveGreySurface,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<String>(
                value: option,
                groupValue: groupValue,
                onChanged: (value) => onChanged(value),
                activeColor: ColorSet.of(context).primary,
              ),
              const SizedBox(width: 3),
              Text(
                option,
                style: TextStyle(
                    height: 2,
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.annotation,
                    color: ColorSet.of(context).text),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const thresholdWidth = 280;

    Widget studentGradeOptionsWidget = screenWidth < thresholdWidth
        ? Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: buildRadioButtons(context),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buildRadioButtons(context),
          );

    return SizedBox(
      width: screenWidth * 0.8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                L10n.gradeRadioBoxLabelText,
                style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.annotation,
                    color: ColorSet.of(context).greyText),
              )
            ],
          ),
          const SizedBox(height: 15),
          studentGradeOptionsWidget,
        ],
      ),
    );
  }
}
