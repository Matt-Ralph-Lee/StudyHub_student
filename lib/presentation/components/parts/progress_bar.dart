import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class ProgressBar extends HookWidget {
  final double progress;
  final String progressText;

  const ProgressBar(
      {super.key, required this.progress, required this.progressText});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text(
          progressText,
          style: TextStyle(
            color: ColorSet.of(context).text,
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header3),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: screenWidth * 0.8,
          height: 7,
          decoration: BoxDecoration(
            color: ColorSet.of(context).greySurface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: screenWidth * 0.8 * progress,
              height: 7,
              decoration: BoxDecoration(
                color: ColorSet.of(context).primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
