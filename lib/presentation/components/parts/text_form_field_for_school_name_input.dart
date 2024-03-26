import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class TextFormFieldForSchoolNameInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const TextFormFieldForSchoolNameInput(
      {super.key, required this.controller, required this.onChanged});

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
                L10n.schoolTextFieldLabelText,
                style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.getFontSize(
                        context, FontSizeSet.annotation),
                    color: ColorSet.of(context).greyText),
              )
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller,
            onChanged: onChanged,
            /*
            validator: (value) {
              //云々カンヌン
            },
            */
            style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
                color: ColorSet.of(context).text),
            cursorColor: ColorSet.of(context).text,
            cursorWidth: screenWidth < 600 ? 1 : 1.5,
            cursorHeight:
                FontSizeSet.getFontSize(context, FontSizeSet.annotation),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0),
              fillColor: ColorSet.of(context).greySurface,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
