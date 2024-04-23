import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';

class RankDescriptionModal extends StatelessWidget {
  const RankDescriptionModal({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final modalWidth = screenWidth * 0.6;
    return Container(
      width: modalWidth,
      padding: EdgeInsets.symmetric(
        horizontal: PaddingSet.getPaddingSize(
          context,
          30,
        ),
        vertical: PaddingSet.getPaddingSize(
          context,
          20,
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorSet.of(context).surface),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(L10n.rankDescriptionText,
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize: FontSizeSet.getFontSize(
                    context,
                    FontSizeSet.body,
                  ),
                  color: ColorSet.of(context).text)),
        ],
      ),
    );
  }
}
