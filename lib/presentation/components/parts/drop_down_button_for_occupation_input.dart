import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/student/models/occupation.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';

class DropDownButtonForOccupationInput extends HookWidget {
  final Occupation? groupValue;
  final ValueChanged<Occupation?> onChanged;

  DropDownButtonForOccupationInput({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  final occupationOptions = Occupation.values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
          ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField<Occupation>(
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
              items: occupationOptions.map((Occupation value) {
                return DropdownMenuItem<Occupation>(
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
          ),
        ],
      ),
    );
  }
}
