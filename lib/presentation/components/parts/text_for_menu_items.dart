import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class TextForMenuItems extends StatelessWidget {
  final String menuItemText;

  const TextForMenuItems({super.key, required this.menuItemText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            menuItemText,
            style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize:
                    FontSizeSet.getFontSize(context, FontSizeSet.annotation),
                color: ColorSet.of(context).greyText),
          )
        ],
      ),
    );
  }
}
