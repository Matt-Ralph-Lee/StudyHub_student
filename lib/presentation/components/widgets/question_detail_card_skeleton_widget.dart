import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/padding_set.dart';

class QuestionDetailCardSkeletonWidget extends StatelessWidget {
  const QuestionDetailCardSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        Expanded(
                          child: Container(
                            height: screenWidth < 600 ? 24 : 32,
                            decoration: BoxDecoration(
                              color: ColorSet.of(context).greySurface,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: PaddingSet.getPaddingSize(
                  context,
                  20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: PaddingSet.getPaddingSize(
                  context,
                  50,
                )),
                child: Column(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
