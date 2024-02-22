import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/padding_set.dart';

class ElevatedButtonForMenuItems extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;

  const ElevatedButtonForMenuItems({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorSet.of(context).surface,
          foregroundColor: ColorSet.of(context).text,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          padding: EdgeInsets.symmetric(
              vertical: PaddingSet.getPaddingSize(
                  context, PaddingSet.elevatedButtonPadding)),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.annotation),
          ),
        ),
      ),
    );
  }
}
