import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/grade_or_graduate_status.dart';
import '../../../domain/student/models/occupation.dart';
import '../parts/circle_avatar_for_profile_edit.dart';
import '../parts/drop_down_button_for_gender_input.dart';
import '../parts/drop_down_button_for_occupation_input.dart';
import '../parts/drop_down_button_for_others_grade_input.dart';
import '../parts/drop_down_button_for_student_grade_input.dart';
import '../parts/text_form_field_for_school_name_input.dart';
import '../parts/text_form_field_for_user_name_input.dart';

class EditProfileWidget extends HookWidget {
  final TextEditingController userNameInputController;
  final TextEditingController studentSchoolNameInputController;
  final void Function(String)? checkUserNameFilledFunction;
  final void Function() uploadPhotoFromCamera;
  final void Function() uploadPhotoFromGallery;
  final String iconUrl;
  final String? imageFilePath;
  final Gender? genderValue;
  final Occupation? occupationValue;
  final GradeOrGraduateStatus? gradeOrGraduateStatusValue;
  final ValueChanged<Gender?> handleGenderChanged;
  final ValueChanged<Occupation?> handleOccupationChanged;
  final ValueChanged<GradeOrGraduateStatus?> handleOthersGradeChanged;

  const EditProfileWidget({
    super.key,
    required this.userNameInputController,
    required this.checkUserNameFilledFunction,
    required this.uploadPhotoFromCamera,
    required this.uploadPhotoFromGallery,
    required this.iconUrl,
    required this.imageFilePath,
    required this.genderValue,
    required this.occupationValue,
    required this.gradeOrGraduateStatusValue,
    required this.handleGenderChanged,
    required this.handleOccupationChanged,
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
          const SizedBox(height: 40),
          TextFormFieldForUserNameInput(
            controller: userNameInputController,
            onChanged: checkUserNameFilledFunction,
          ),
          const SizedBox(height: 40),
          DropDownButtonForGenderInput(
            groupValue: genderValue,
            onChanged: handleGenderChanged,
          ),
          const SizedBox(height: 40),
          TextFormFieldForSchoolNameInput(
            controller: studentSchoolNameInputController,
          ),
          const SizedBox(height: 40),
          DropDownButtonForOccupationInput(
            groupValue: occupationValue,
            onChanged: handleOccupationChanged,
          ),
          const SizedBox(height: 40),
          (occupationValue == Occupation.student || occupationValue == null)
              ? DropDownButtonForStudentGradeInput(
                  groupValue: gradeOrGraduateStatusValue,
                  onChanged: handleOthersGradeChanged,
                )
              : DropDownButtonForOthersGradeInput(
                  groupValue: gradeOrGraduateStatusValue,
                  onChanged: handleOthersGradeChanged,
                ),
        ],
      ),
    );
  }
}
