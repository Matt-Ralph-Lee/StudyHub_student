import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/padding_set.dart';

class QuestionAndAnswerCardSkeletonWidget extends ConsumerWidget {
  const QuestionAndAnswerCardSkeletonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
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
          screenWidth < 600 ? 20 : 40,
        ),
        child: Shimmer.fromColors(
          baseColor: ColorSet.of(context).simmerBase,
          highlightColor: ColorSet.of(context).simmerHighlight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: screenWidth < 600 ? 15 : 22,
                    backgroundColor: ColorSet.of(context).greySurface,
                  ),
                  SizedBox(
                    width: PaddingSet.getPaddingSize(
                      context,
                      20,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
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
                        SizedBox(
                          height: PaddingSet.getPaddingSize(
                            context,
                            10,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: PaddingSet.getPaddingSize(
                  context,
                  10,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: PaddingSet.getPaddingSize(
                      context,
                      50,
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
                  SizedBox(
                    width: PaddingSet.getPaddingSize(
                      context,
                      20,
                    ),
                  ),
                  CircleAvatar(
                    radius: screenWidth < 600 ? 15 : 22,
                    backgroundColor: ColorSet.of(context).greySurface,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
