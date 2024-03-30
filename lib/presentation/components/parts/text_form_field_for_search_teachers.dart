import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/padding_set.dart';

class TextFormFieldForSearchForTeachers extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSearched;

  const TextFormFieldForSearchForTeachers({
    super.key,
    required this.controller,
    required this.onSearched,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: screenWidth < 600 ? 30 : 45,
      child: TextFormField(
        controller: controller,
        // onChanged: onChanged,
        style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
            color: ColorSet.of(context).text),
        cursorColor: ColorSet.of(context).text,
        cursorWidth: screenWidth < 600 ? 1 : 1.5,
        cursorHeight: FontSizeSet.getFontSize(context, FontSizeSet.body),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: PaddingSet.getPaddingSize(context, 5),
            bottom: PaddingSet.getPaddingSize(context, 5),
            left: PaddingSet.getPaddingSize(context, 5),
          ),
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
          prefixIcon: Icon(
            Icons.search,
            color: ColorSet.of(context).icon,
            size: FontSizeSet.getFontSize(
              context,
              FontSizeSet.body,
            ),
          ),
        ),
        maxLines: 1,
        onFieldSubmitted: onSearched,
      ),
    );
  }
}
