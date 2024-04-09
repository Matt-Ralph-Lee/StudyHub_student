import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';

class TextButtonForNavigatingToEvaluationPage extends StatelessWidget {
  final TeacherId teacherId;
  final AnswerId fromAnswer;
  final QuestionId fromQuestion;
  const TextButtonForNavigatingToEvaluationPage({
    Key? key,
    required this.teacherId,
    required this.fromAnswer,
    required this.fromQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void push(BuildContext context) {
      context.push(
        PageId.evaluationPage.path,
        extra: [
          teacherId,
          fromAnswer,
          fromQuestion,
        ],
      );
    }

    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => push(context),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorSet.of(context).primary),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          L10n.navigateToEvaluationPage,
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
              color: ColorSet.of(context).primary),
        ),
      ),
    );
  }
}
