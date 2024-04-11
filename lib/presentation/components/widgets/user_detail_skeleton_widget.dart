import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/padding_set.dart';

class UserDetailSkeletonWidget extends StatelessWidget {
  const UserDetailSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double thisWidth = MediaQuery.of(context).size.width - 40;

    return Shimmer.fromColors(
      baseColor: ColorSet.of(context).simmerBase,
      highlightColor: ColorSet.of(context).simmerHighlight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
            height: PaddingSet.getPaddingSize(
              context,
              10,
            ),
          ),
          Container(
            width: screenWidth / 2,
            height: screenWidth < 600 ? 18 : 27,
            decoration: BoxDecoration(
              color: ColorSet.of(context).greySurface,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(
            height: PaddingSet.getPaddingSize(
              context,
              20,
            ),
          ),
          Container(
            height: screenWidth < 600 ? 5 : 7,
            width: thisWidth,
            decoration: BoxDecoration(
              color: ColorSet.of(context).greySurface,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(
            height: PaddingSet.getPaddingSize(
              context,
              10,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: screenWidth < 600 ? 60 : 90,
                height: screenWidth < 600 ? 20 : 30,
                decoration: BoxDecoration(
                  color: ColorSet.of(context).greySurface,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
