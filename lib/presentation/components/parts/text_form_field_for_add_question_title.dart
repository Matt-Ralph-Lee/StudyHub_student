import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';

class TextFormFieldForAddQuestionTitle extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const TextFormFieldForAddQuestionTitle({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
            fontWeight: FontWeightSet.semibold,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header2),
            color: ColorSet.of(context).text),
        cursorColor: ColorSet.of(context).text,
        cursorWidth: screenWidth < 600 ? 1 : 1.5,
        cursorHeight: FontSizeSet.getFontSize(context, FontSizeSet.header2),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            left: 0,
          ),
          hintText: L10n.questionTitleHintText,
          hintStyle: TextStyle(
              fontWeight: FontWeightSet.semibold,
              fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header2),
              color: ColorSet.of(context).greyText),
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none,
          ),
        ),
        maxLines: 2,
      ),
    );
  }
}
