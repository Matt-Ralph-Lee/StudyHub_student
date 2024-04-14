import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/padding_set.dart';

class EvaluationCardSkeletonWidget extends StatelessWidget {
  const EvaluationCardSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
        padding: EdgeInsets.all(
          PaddingSet.getPaddingSize(
            context,
            PaddingSet.pageViewItemLightPadding,
          ),
        ),
        child: Shimmer.fromColors(
          baseColor: ColorSet.of(context).simmerBase,
          highlightColor: ColorSet.of(context).simmerHighlight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: screenWidth < 600 ? 30 : 44,
                    height: screenWidth < 600 ? 30 : 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorSet.of(context).greySurface,
                    ),
                  ),
                  Container(
                    width: screenWidth < 600 ? 50 : 75,
                    height: screenWidth < 600 ? 18 : 27,
                    decoration: BoxDecoration(
                      color: ColorSet.of(context).greySurface,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: PaddingSet.getPaddingSize(
                  context,
                  10,
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Padding(
                      padding: EdgeInsets.only(
                        right: PaddingSet.getPaddingSize(
                          context,
                          5,
                        ),
                      ),
                      child: Icon(
                        Icons.star_border,
                        color: ColorSet.of(context).greySurface,
                        size:
                            FontSizeSet.getFontSize(context, FontSizeSet.body),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: PaddingSet.getPaddingSize(
                  context,
                  15,
                ),
              ),
              Column(
                children: List.generate(
                    3,
                    (index) => Container(
                          width: double.infinity,
                          height: screenWidth < 600 ? 20 : 30,
                          decoration: BoxDecoration(
                            color: ColorSet.of(context).greySurface,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: EdgeInsets.only(
                            bottom: screenWidth < 600 ? 5 : 7,
                          ),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
