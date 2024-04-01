import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/student/models/grade_or_graduate_status.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';

class DropDownButtonForStudentGradeInput extends HookWidget {
  final GradeOrGraduateStatus? groupValue;
  final ValueChanged<GradeOrGraduateStatus?> onChanged;

  DropDownButtonForStudentGradeInput({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  final studentGradeOptions = GradeOrGraduateStatus.values
      .where((element) =>
          element != GradeOrGraduateStatus.graduate &&
          element != GradeOrGraduateStatus.other)
      .toList();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                L10n.genderRadioBoxLabelText,
                style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.getFontSize(
                        context, FontSizeSet.annotation),
                    color: ColorSet.of(context).greyText),
              )
            ],
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<GradeOrGraduateStatus>(
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              fillColor: ColorSet.of(context).greySurface,
              contentPadding: EdgeInsets.symmetric(
                vertical: PaddingSet.getPaddingSize(context, 15),
                horizontal: PaddingSet.getPaddingSize(context, 20),
              ),
            ),
            isExpanded: true,
            value: groupValue,
            dropdownColor: ColorSet.of(context).greySurface,
            onChanged: onChanged,
            items: studentGradeOptions.map((GradeOrGraduateStatus value) {
              return DropdownMenuItem<GradeOrGraduateStatus>(
                value: value,
                child: Text(
                  value.japanese,
                  style: TextStyle(
                      height: 2,
                      fontWeight: FontWeightSet.normal,
                      fontSize: FontSizeSet.getFontSize(
                          context, FontSizeSet.annotation),
                      color: ColorSet.of(context).text),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
