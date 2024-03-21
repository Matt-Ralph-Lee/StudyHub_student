import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../shared/constants/l10n.dart';
import '../parts/button_for_profile_input_back.dart';
import '../parts/button_for_profile_input_next.dart';
import '../parts/button_for_profile_input_skip.dart';
import '../parts/radio_button_for_student_grade_input.dart';
import '../parts/text_for_input_explanation.dart';
import '../parts/text_form_field_for_school_name_input.dart';

class StudentSchoolNameAndGradeInputWidget extends HookWidget {
  final VoidCallback decrementProgressCounter;
  final VoidCallback updateProfile;
  final TextEditingController studentSchoolNameInputController;
  final String? studentGradeValue;
  final ValueChanged<String?> handleStudentGradeChanged;

  const StudentSchoolNameAndGradeInputWidget(
      {super.key,
      required this.decrementProgressCounter,
      required this.updateProfile,
      required this.studentSchoolNameInputController,
      required this.studentGradeValue,
      required this.handleStudentGradeChanged});

  @override
  Widget build(BuildContext context) {
    final isSchoolNameFilled =
        useState<bool>(studentSchoolNameInputController.text.isNotEmpty);

    void checkSchoolNameFilled(String text) {
      isSchoolNameFilled.value = text.isNotEmpty;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TextForProfileInputExplanation(
            explanationText: L10n.schoolAndGradeInputExplanationText),
        const SizedBox(height: 70),
        TextFormFieldForSchoolNameInput(
          controller: studentSchoolNameInputController,
          onChanged: checkSchoolNameFilled,
        ),
        const SizedBox(height: 50),
        RadioButtonForStudentGradeInput(
          groupValue: studentGradeValue,
          onChanged: handleStudentGradeChanged,
        ),
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonForProfileInputBack(
              decrementCounter: decrementProgressCounter,
            ),
            ButtonForProfileInputSkip(
              skipCounter: updateProfile,
            ),
            ButtonForProfileInputNext(
              incrementCounter:
                  (isSchoolNameFilled.value && studentGradeValue != null)
                      ? updateProfile
                      : null,
            )
          ],
        ),
      ],
    );
  }
}
