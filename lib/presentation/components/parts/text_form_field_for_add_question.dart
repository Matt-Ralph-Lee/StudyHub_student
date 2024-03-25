import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class TextFormFieldForAddQuestion extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const TextFormFieldForAddQuestion({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.body,
            color: ColorSet.of(context).text),
        cursorColor: ColorSet.of(context).text,
        cursorWidth: 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 0),
          hintText: "質問内容を入力してください",
          hintStyle: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.body,
              color: ColorSet.of(context).greyText),
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none,
          ),
        ),
        maxLines: 15,
      ),
    );
  }
}
