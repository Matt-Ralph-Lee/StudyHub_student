import 'package:flutter/material.dart';

import '../../../domain/shared/subject.dart';
import '../../shared/constants/padding_set.dart';
import '../parts/drop_down_button_for_question_subject.dart';
import '../parts/text_form_field_for_add_question_title.dart';
import '../parts/text_form_field_for_add_question.dart';

class AddQuestionMainContentWidget extends StatelessWidget {
  final TextEditingController questionTitleController;
  final TextEditingController questionController;
  final void Function(Subject?) selectSubjectFunction;
  final void Function(String) checkQuestionTitleFilledFunction;
  final void Function(String) checkQuestionFilledFunction;
  final String? questionTitleErrorText;
  final String? questionErrorText;
  const AddQuestionMainContentWidget({
    super.key,
    required this.questionController,
    required this.questionTitleController,
    required this.selectSubjectFunction,
    required this.checkQuestionFilledFunction,
    required this.checkQuestionTitleFilledFunction,
    required this.questionErrorText,
    required this.questionTitleErrorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropDownButtonForQuestionSubject(
          setSubject: selectSubjectFunction,
        ),
        SizedBox(
          height: PaddingSet.getPaddingSize(
            context,
            30,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: PaddingSet.getPaddingSize(
            context,
            PaddingSet.horizontalPadding,
          )), //DropdownButtonのButtonThemeでalginをtrueにしている以上、こうしないと左端が揃わないので(ipadで若干ずれるのは妥協)
          child: Column(
            children: [
              TextFormFieldForAddQuestionTitle(
                controller: questionTitleController,
                onChanged: checkQuestionTitleFilledFunction,
                errorText: questionTitleErrorText,
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
                errorText: questionErrorText,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
