import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

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
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        // onChanged: onChanged,
        style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.annotation,
            color: ColorSet.of(context).text),
        cursorColor: ColorSet.of(context).text,
        cursorWidth: 1,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0),
          hintText: "キーワードを入力してください",
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
