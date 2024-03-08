import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/student/models/occupation.dart';
import '../parts/circle_avatar_for_profile_edit.dart';
import '../parts/radio_button_for_gender_input.dart';
import '../parts/radio_button_for_occupation_input.dart';
import '../parts/radio_button_for_others_grade_input.dart';
import '../parts/radio_button_for_student_grade_input.dart';
import '../parts/text_form_field_for_school_name_input.dart';
import '../parts/text_form_field_for_user_name_input.dart';

class EditProfileWidget extends HookWidget {
  final TextEditingController userNameInputController;
  final TextEditingController studentSchoolNameInputController;
  final void Function(String)? checkUserNameFilledFunction;
  final void Function(String)? checkSchoolNameFilledFunction;
  final void Function() uploadPhotoFromCamera;
  final void Function() uploadPhotoFromGallery;
  final String iconUrl;
  final String? imageFilePath;
  final String? genderValue;
  final String? occupationValue;
  final String? studentGradeValue;
  final String? othersGradeValue;
  final ValueChanged<String?> handleGenderChanged;
  final ValueChanged<String?> handleOccupationChanged;
  final ValueChanged<String?> handleStudentGradeChanged;
  final ValueChanged<String?> handleOthersGradeChanged;

  const EditProfileWidget({
    super.key,
    required this.userNameInputController,
    required this.checkUserNameFilledFunction,
    required this.checkSchoolNameFilledFunction,
    required this.uploadPhotoFromCamera,
    required this.uploadPhotoFromGallery,
    required this.iconUrl,
    required this.imageFilePath,
    required this.genderValue,
    required this.occupationValue,
    required this.studentGradeValue,
    required this.othersGradeValue,
    required this.handleGenderChanged,
    required this.handleOccupationChanged,
    required this.handleStudentGradeChanged,
    required this.handleOthersGradeChanged,
    required this.studentSchoolNameInputController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          CircleAvatarForProfileEdit(
            iconUrl: iconUrl,
            takePhoto: uploadPhotoFromCamera,
            pickPhoto: uploadPhotoFromGallery,
            imageFilePath: imageFilePath,
          ),
          const SizedBox(height: 25),
          TextFormFieldForUserNameInput(
            controller: userNameInputController,
            onChanged: checkUserNameFilledFunction,
          ),
          const SizedBox(height: 25),
          RadioButtonForGenderInput(
            groupValue: genderValue,
            onChanged: handleGenderChanged,
          ),
          const SizedBox(height: 25),
          TextFormFieldForSchoolNameInput(
            controller: studentSchoolNameInputController,
            onChanged: checkSchoolNameFilledFunction,
          ),
          const SizedBox(height: 25),
          RadioButtonForOccupationInput(
            groupValue: occupationValue,
            onChanged: handleOccupationChanged,
          ),
          const SizedBox(height: 25),
          (occupationValue == Occupation.student.japanese ||
                  occupationValue == null)
              ? RadioButtonForStudentGradeInput(
                  groupValue: studentGradeValue,
                  onChanged: handleStudentGradeChanged,
                )
              : RadioButtonForOthersGradeInput(
                  groupValue: othersGradeValue,
                  onChanged: handleOthersGradeChanged,
                ),
        ],
      ),
    );
  }
}
