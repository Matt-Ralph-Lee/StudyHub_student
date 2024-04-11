import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/padding_set.dart';

class TeacherProfileSkeletonWidget extends StatelessWidget {
  const TeacherProfileSkeletonWidget({super.key});

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
        padding: EdgeInsets.all(
          screenWidth < 600 ? 20 : 40,
        ),
        child: Shimmer.fromColors(
          baseColor: ColorSet.of(context).simmerBase,
          highlightColor: ColorSet.of(context).simmerHighlight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth < 600 ? 80 : 120,
                    height: screenWidth < 600 ? 80 : 120,
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
                      height: screenWidth < 600 ? 30 : 45,
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
                  30,
                ),
              ),
              Column(
                children: List.generate(
                    5,
                    (index) => Padding(
                          padding: EdgeInsets.only(
                            bottom: PaddingSet.getPaddingSize(
                              context,
                              10,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: screenWidth < 600 ? 18 : 27,
                                decoration: BoxDecoration(
                                  color: ColorSet.of(context).greySurface,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              SizedBox(
                                height: PaddingSet.getPaddingSize(
                                  context,
                                  5,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: screenWidth < 600 ? 20 : 30,
                                decoration: BoxDecoration(
                                  color: ColorSet.of(context).greySurface,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ],
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
