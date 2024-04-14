import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/padding_set.dart';

class TeacherProfileWForConfirmSkeletonWidget extends StatelessWidget {
  const TeacherProfileWForConfirmSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth < 600 ? 5 : 10,
          horizontal: screenWidth < 600 ? 20 : 40,
        ),
        child: Shimmer.fromColors(
          baseColor: ColorSet.of(context).simmerBase,
          highlightColor: ColorSet.of(context).simmerHighlight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: screenWidth < 600 ? 30 : 44,
                height: screenWidth < 600 ? 30 : 44,
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
              Container(
                width: screenWidth * 0.3,
                height: screenWidth < 600 ? 20 : 30,
                decoration: BoxDecoration(
                  color: ColorSet.of(context).greySurface,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
