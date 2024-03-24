import 'package:flutter/material.dart';

import '../../../domain/shared/subject.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/padding_set.dart';
import '../parts/dropdown_for_question_subject.dart';
import '../parts/elevated_button_for_adding_picture.dart';
import '../parts/text_button_for_selecting_teachers.dart';
import '../parts/text_form_field_for_add_question_title.dart';
import '../parts/text_form_field_for_add_question.dart';

class CreateQuestionWidget extends StatelessWidget {
  final TextEditingController questionTitleController;
  final TextEditingController questionController;
  final List<String>? imageFilePath;
  final void Function() uploadPhotoFromCamera;
  final void Function() uploadPhotoFromGallery;
  final void Function(Subject?) selectSubjectFunction;
  final void Function(List<TeacherId>) selectTeachersFunction;
  final void Function(String) checkQuestionTitleFilledFunction;
  final void Function(String) checkQuestionFilledFunction;
  const CreateQuestionWidget({
    super.key,
    required this.questionController,
    required this.questionTitleController,
    required this.imageFilePath,
    required this.uploadPhotoFromCamera,
    required this.uploadPhotoFromGallery,
    required this.selectSubjectFunction,
    required this.selectTeachersFunction,
    required this.checkQuestionFilledFunction,
    required this.checkQuestionTitleFilledFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          TextFormFieldForAddQuestionTitle(
            controller: questionTitleController,
            onChanged: checkQuestionTitleFilledFunction,
          ),
          SizedBox(
            height: PaddingSet.getPaddingSize(
              context,
              20,
            ),
          ),
          DropDownForQuestionSubject(
            setSubject: selectSubjectFunction,
          ),
          SizedBox(
            height: PaddingSet.getPaddingSize(
              context,
              20,
            ),
          ),
          TextFormFieldForAddQuestion(
            controller: questionController,
            onChanged: checkQuestionFilledFunction,
          ),
          SizedBox(
            height: PaddingSet.getPaddingSize(
              context,
              20,
            ),
          ),
          ElevatedButtonForAddingPicture(
            imageFilePath: imageFilePath,
            takePhoto: uploadPhotoFromCamera,
            pickPhoto: uploadPhotoFromGallery,
          ),
          SizedBox(
            height: PaddingSet.getPaddingSize(
              context,
              20,
            ),
          ),
          TextButtonForSelectingTeacher(
            selectTeachersFunction: selectTeachersFunction,
          ),
        ],
      ),
    );
  }
}
