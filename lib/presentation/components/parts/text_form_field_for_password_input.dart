import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class TextFormFieldForPasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const TextFormFieldForPasswordInput(
      {super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.8,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        /*
        validator: (value) {
          //云々カンヌン
        },
        */
        style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.annotation,
            color: ColorSet.of(context).text),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0),
          hintText: L10n.passwordTextFieldHintText,
          hintStyle: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.annotation,
              color: ColorSet.of(context).greyText),
          fillColor: ColorSet.of(context).greySurface,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
