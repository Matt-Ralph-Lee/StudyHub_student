import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/student/models/occupation.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class RadioButtonForOccupationInput extends HookWidget {
  final Occupation? groupValue;
  final ValueChanged<Occupation?> onChanged;

  RadioButtonForOccupationInput({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  // Occupation.valuesを直接使用します。
  final occupationOptions = Occupation.values;

  List<Widget> buildRadioButtons(BuildContext context) {
    return occupationOptions.map((occupation) {
      return GestureDetector(
        onTap: () => onChanged(occupation),
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: ColorSet.of(context).inactiveGreySurface,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<Occupation>(
                value: occupation,
                groupValue: groupValue,
                onChanged: (value) => onChanged(value),
                activeColor: ColorSet.of(context).primary,
              ),
              const SizedBox(width: 3),
              Text(
                occupation.japanese,
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

    const thresholdWidth = 330;

    Widget jobOptionsWidget = screenWidth < thresholdWidth
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
                L10n.jobRadioBoxLabelText,
                style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.getFontSize(
                        context, FontSizeSet.annotation),
                    color: ColorSet.of(context).greyText),
              )
            ],
          ),
          const SizedBox(height: 10),
          jobOptionsWidget,
        ],
      ),
    );
  }
}
