import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/answer/application_service/answer_dto.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../controllers/like_answer_controller/like_answer_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/page_path.dart';
import 'answer_menu_modal_widget.dart';

class AnswerCardWidget extends ConsumerWidget {
  final AnswerDto answerDto;

  const AnswerCardWidget({
    super.key,
    required this.answerDto,
  });

  @override
  Widget build(BuildContext context, ref) {
    final double screenWidth = MediaQuery.of(context).size.width;

    void toggleLikeAnswer() async {
      if (answerDto.hasLiked) {
        ref
            .read(likeAnswerControllerProvider.notifier)
            .decrement(answerDto.answerId);
      } else {
        ref
            .read(likeAnswerControllerProvider.notifier)
            .increment(answerDto.answerId);
      }
    }

    void navigateToTeacherProfilePage(
        BuildContext context, TeacherId teacherId) {
      context.push(PageId.teacherProfile.path, extra: teacherId);
    }

    void showAnswerMenuDialog(BuildContext context, AnswerDto answerDto) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Dialog(
              child: Align(
                alignment: Alignment.centerRight,
                child: AnswerMenuModalWidget(
                  answerDto: answerDto,
                ),
              ),
            ),
          );
        },
      );
    }

    return Container(
      width: screenWidth * 0.8, //ここ適当。
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => navigateToTeacherProfilePage(
                        context, answerDto.teacherId),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              answerDto.teacherProfilePath.contains("assets")
                                  ? AssetImage(answerDto.teacherProfilePath)
                                      as ImageProvider
                                  : NetworkImage(
                                      answerDto.teacherProfilePath,
                                    ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            answerDto.teacherName,
                            style: TextStyle(
                              fontWeight: FontWeightSet.normal,
                              fontSize: FontSizeSet.getFontSize(
                                  context, FontSizeSet.header3),
                              color: ColorSet.of(context).text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.more_vert,
                    color: ColorSet.of(context).text,
                    size: FontSizeSet.getFontSize(context, FontSizeSet.body),
                  ),
                  onPressed: () {
                    showAnswerMenuDialog(
                      context,
                      answerDto,
                    );
                  },
                )
                // answerDto.isFollowing
                //     ? TextButtonForUnFollowTeacher(
                //         onPressed: () => deleteFavoriteTeacher())
                //     : TextButtonForFollowTeacher(
                //         onPressed: () => addFavoriteTeacher()),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: toggleLikeAnswer,
                  child: SizedBox(
                    width: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          answerDto.hasLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 17,
                          color: ColorSet.of(context).primary,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          answerDto.answerLike.toString(),
                          style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.annotation),
                            color: ColorSet.of(context).text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    answerDto.answerText,
                    style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize:
                          FontSizeSet.getFontSize(context, FontSizeSet.body),
                      color: ColorSet.of(context).text,
                    ),
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
