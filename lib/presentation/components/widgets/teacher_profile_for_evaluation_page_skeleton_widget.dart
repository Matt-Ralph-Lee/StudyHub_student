import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/padding_set.dart';

class TeacherProfileForEvaluationPageSkeletonWidget extends StatelessWidget {
  const TeacherProfileForEvaluationPageSkeletonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: screenWidth < 600 ? 5 : 10,
        horizontal: screenWidth < 600 ? 20 : 40,
      ),
      decoration: BoxDecoration(
        color: ColorSet.of(context).surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: ColorSet.of(context).cardShadow,
              spreadRadius: 0,
              blurRadius: 16,
              offset: const Offset(0, 0)),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: ColorSet.of(context).simmerBase,
        highlightColor: ColorSet.of(context).simmerHighlight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenWidth < 600 ? 60 : 90,
              height: screenWidth < 600 ? 60 : 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorSet.of(context).greySurface,
              ),
            ),
            SizedBox(
              width: PaddingSet.getPaddingSize(
                context,
                20,
              ),
            ),
            Expanded(
              child: Container(
                height: screenWidth < 600 ? 20 : 30,
                decoration: BoxDecoration(
                  color: ColorSet.of(context).greySurface,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
