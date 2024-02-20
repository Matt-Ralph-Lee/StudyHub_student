import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class ElevatedButtonForAuth extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;

  const ElevatedButtonForAuth({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.8,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorSet.of(context).primary,
          disabledBackgroundColor: ColorSet.of(context).inactiveGreySurface,
          foregroundColor: ColorSet.of(context).whiteText,
          disabledForegroundColor: ColorSet.of(context).unselectedText,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.annotation,
          ),
        ),
      ),
    );
  }
}