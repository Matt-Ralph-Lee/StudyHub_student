import "package:flutter/material.dart";

import "../../shared/constants/color_set.dart";
import "../../shared/constants/font_size_set.dart";
import "../../shared/constants/font_weight_set.dart";
import "../../shared/constants/l10n.dart";
import "../../shared/constants/padding_set.dart";

class TextFormFieldForEmailAddressInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? errorText;

  const TextFormFieldForEmailAddressInput({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.8,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
            color: ColorSet.of(context).text),
        cursorColor: ColorSet.of(context).text,
        cursorWidth: screenWidth < 600 ? 1 : 1.5,
        cursorHeight: FontSizeSet.getFontSize(context, FontSizeSet.body),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: PaddingSet.getPaddingSize(context, 15),
            bottom: PaddingSet.getPaddingSize(context, 15),
            left: PaddingSet.getPaddingSize(context, 20),
          ),
          hintText: L10n.emailTextFieldHintText,
          hintStyle: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(
                context,
                FontSizeSet.annotation,
              ),
              color: ColorSet.of(context).greyText),
          fillColor: ColorSet.of(context).greySurface,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none,
          ),
          errorText: errorText,
          errorStyle: const TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.annotation,
              color: Colors.red),
          errorMaxLines: 2,
        ),
      ),
    );
  }
}
