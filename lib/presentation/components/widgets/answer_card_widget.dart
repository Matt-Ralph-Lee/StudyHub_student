import 'package:flutter/material.dart';
import 'package:studyhub/presentation/components/parts/text_button_for_follow_teacher.dart';
import 'package:studyhub/presentation/components/parts/text_button_for_unfollow_teacher.dart';

import '../../../application/shared/application_service/question_card_dto.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class AnswerCardWidget extends StatelessWidget {
  final QuestionCardDto questionCardDto;
  final bool isFollowed;
  final VoidCallback followFunction;
  final VoidCallback unFollowFunction;

  //DTOで受け取るようにする？

  const AnswerCardWidget({
    super.key,
    required this.questionCardDto,
    required this.isFollowed,
    required this.followFunction,
    required this.unFollowFunction,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text(
          "講師からの回答",
          style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header3),
            color: ColorSet.of(context).text,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
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
            padding: EdgeInsets.all(
              screenWidth < 600 ? 20 : 40,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                        questionCardDto.teacherProfilePhotoPath != null
                            ? questionCardDto.teacherProfilePhotoPath
                            : "適当なパス",
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "講師の名前", //これどうやって取得する？questionDtoからは取得できない
                      style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                            context, FontSizeSet.header3),
                        color: ColorSet.of(context).text,
                      ),
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    isFollowed
                        ? TextButtonForFollowTeacher(onPressed: followFunction)
                        : TextButtonForUnFollowTeacher(
                            onPressed: unFollowFunction),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.heart_broken,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "100", //回答のいいねの数ってどこからとれる？少なくともquestionDtoからはとれない
                          style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.body),
                            color: ColorSet.of(context).text,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            questionCardDto.answerText != null
                                ? questionCardDto.answerText!
                                : "回答はまだです❗",
                            style: TextStyle(
                              fontWeight: FontWeightSet.normal,
                              fontSize: FontSizeSet.getFontSize(
                                  context, FontSizeSet.body),
                              color: ColorSet.of(context).text,
                            ),
                            // maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
