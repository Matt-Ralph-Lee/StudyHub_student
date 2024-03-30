import 'package:flutter/material.dart';

import '../../../domain/shared/subject.dart';
import '../../shared/constants/padding_set.dart';
import '../parts/dropdown_for_question_subject.dart';
import '../parts/text_form_field_for_add_question_title.dart';
import '../parts/text_form_field_for_add_question.dart';

class AddQuestionMainContentWidget extends StatelessWidget {
  final TextEditingController questionTitleController;
  final TextEditingController questionController;
  final void Function(Subject?) selectSubjectFunction;
  final void Function(String) checkQuestionTitleFilledFunction;
  final void Function(String) checkQuestionFilledFunction;
  const AddQuestionMainContentWidget({
    super.key,
    required this.questionController,
    required this.questionTitleController,
    required this.selectSubjectFunction,
    required this.checkQuestionFilledFunction,
    required this.checkQuestionTitleFilledFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          DropDownForQuestionSubject(
            setSubject: selectSubjectFunction,
          ),
          SizedBox(
            height: PaddingSet.getPaddingSize(
              context,
              30,
            ),
          ),
          TextFormFieldForAddQuestionTitle(
            controller: questionTitleController,
            onChanged: checkQuestionTitleFilledFunction,
          ),
          SizedBox(
            height: PaddingSet.getPaddingSize(
              context,
              30,
            ),
          ), //タイトルのmaxLine分空いてるからキモいけど仕方ない
          TextFormFieldForAddQuestion(
            controller: questionController,
            onChanged: checkQuestionFilledFunction,
          ),
        ],
      ),
    );
  }
}
