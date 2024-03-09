import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class QuestionCardWidget extends StatelessWidget {
  final String questionTitle;
  final String question;
  final String studentIconUrl;
  final String teacherIconUrl;
  final String answer;
  final bool isBookmarked;

  const QuestionCardWidget({
    super.key,
    required this.questionTitle,
    required this.question,
    required this.studentIconUrl,
    required this.teacherIconUrl,
    required this.answer,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenWidth < 600 ? 155 : 220,
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
        padding: EdgeInsets.only(
          right: screenWidth < 600 ? 20 : 40,
          left: screenWidth < 600 ? 20 : 40,
          bottom: FontSizeSet.getFontSize(context, FontSizeSet.header3),
        ),
        child: Column(
          children: [
            isBookmarked == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.bookmark,
                          color: ColorSet.of(context).primary,
                          size: FontSizeSet.getFontSize(
                              context, FontSizeSet.header3),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height:
                        FontSizeSet.getFontSize(context, FontSizeSet.header3),
                  ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                      studentIconUrl,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              L10n.questionIconText,
                              style: TextStyle(
                                  fontWeight: FontWeightSet.normal,
                                  fontSize: FontSizeSet.getFontSize(
                                      context, FontSizeSet.header3),
                                  color: ColorSet.of(context).questionIcon),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                questionTitle,
                                style: TextStyle(
                                    fontWeight: FontWeightSet.normal,
                                    fontSize: FontSizeSet.getFontSize(
                                        context, FontSizeSet.header3),
                                    color: ColorSet.of(context).text),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(question,
                                    style: TextStyle(
                                        fontWeight: FontWeightSet.normal,
                                        fontSize: FontSizeSet.getFontSize(
                                            context, FontSizeSet.body),
                                        color: ColorSet.of(context).text),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenWidth < 600 ? 10 : 20,
            ),
            //回答
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 50,
                ),
                Text(
                  L10n.answerIconText,
                  style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize:
                          FontSizeSet.getFontSize(context, FontSizeSet.header3),
                      color: ColorSet.of(context).answerIcon),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    answer,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize:
                            FontSizeSet.getFontSize(context, FontSizeSet.body),
                        color: ColorSet.of(context).text),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    teacherIconUrl,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
