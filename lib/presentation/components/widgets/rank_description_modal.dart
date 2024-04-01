import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class RankDescriptionModal extends StatelessWidget {
  const RankDescriptionModal({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final modalWidth = screenWidth * 0.6;
    return Container(
      width: modalWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorSet.of(context).surface),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "質問数に応じて、Beginner/Novice/Advanced/Expertのいずれかのランクが付与されます。高ランクを目指して沢山質問しましょう！",
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize: FontSizeSet.annotation,
                  color: ColorSet.of(context).text)),
        ],
      ),
    );
  }
}
