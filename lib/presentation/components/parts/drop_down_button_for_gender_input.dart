import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:studyhub/domain/student/models/gender.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';

class DropDownButtonForGenderInput extends HookWidget {
  final Gender? groupValue;
  final ValueChanged<Gender?> onChanged;

  DropDownButtonForGenderInput({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  final genderOptions = Gender.values;

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
          DropdownButtonFormField<Gender>(
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
            items: genderOptions.map((Gender value) {
              return DropdownMenuItem<Gender>(
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
