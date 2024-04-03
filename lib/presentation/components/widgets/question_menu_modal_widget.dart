import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/domain/question/models/question_id.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';

class QuestionMenuModalWidget extends ConsumerWidget {
  final QuestionId questionId;
  const QuestionMenuModalWidget({
    super.key,
    required this.questionId,
  });

  @override
  Widget build(BuildContext context, ref) {
    void navigateToReportPage(BuildContext context, QuestionId questionId) {
      context.push(
        PageId.reportQuestionPage.path,
        extra: [
          questionId,
          null,
        ],
      );
      context.pop();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorSet.of(context).surface),
      child: GestureDetector(
        onTap: () => navigateToReportPage(
          context,
          questionId,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L10n.reportText,
              style: TextStyle(
                color: ColorSet.of(context).text,
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
