import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';

class TextFormFieldForPasswordInput extends HookWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? errorText;

  const TextFormFieldForPasswordInput(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.errorText});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isObscure = useState<bool>(true);

    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        obscureText: isObscure.value,
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
          suffixIcon: IconButton(
            icon: Icon(
              isObscure.value ? Icons.visibility_off : Icons.visibility,
              color: ColorSet.of(context).primary,
              size: FontSizeSet.getFontSize(
                context,
                FontSizeSet.header2,
              ),
            ),
            onPressed: () {
              isObscure.value = !isObscure.value;
            },
          ),
          contentPadding: EdgeInsets.only(
            top: PaddingSet.getPaddingSize(context, 15),
            bottom: PaddingSet.getPaddingSize(context, 15),
            left: PaddingSet.getPaddingSize(context, 20),
          ),
          hintText: L10n.passwordTextFieldHintText,
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
          errorStyle: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.annotation,
              color: ColorSet.of(context).errorText),
          errorMaxLines: 2,
        ),
      ),
    );
  }
}
