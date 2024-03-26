import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:studyhub/domain/student/models/gender.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class RadioButtonForGenderInput extends HookWidget {
  final Gender? groupValue;
  final ValueChanged<Gender?> onChanged;

  RadioButtonForGenderInput({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  final genderOptions = Gender.values;

  List<Widget> buildRadioButtons(BuildContext context) {
    return genderOptions.map((gender) {
      return GestureDetector(
        onTap: () => onChanged(gender),
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: ColorSet.of(context).inactiveGreySurface,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<Gender>(
                value: gender,
                groupValue: groupValue,
                onChanged: (value) => onChanged(value),
                activeColor: ColorSet.of(context).primary,
              ),
              const SizedBox(width: 3),
              Text(
                gender.japanese,
                style: TextStyle(
                    height: 2,
                    fontWeight: FontWeightSet.normal,
                    fontSize:
                        FontSizeSet.getFontSize(context, FontSizeSet.body),
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

    const thresholdWidth = 360;

    Widget genderOptionsWidget = screenWidth < thresholdWidth
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
          genderOptionsWidget,
        ],
      ),
    );
  }
}
