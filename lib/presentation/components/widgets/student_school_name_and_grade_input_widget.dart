import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../parts/button_for_profile_input_back.dart';
import '../parts/button_for_profile_input_next.dart';
import '../parts/button_for_profile_input_skip.dart';
import '../parts/radio_button_for_student_grade_input.dart';
import '../parts/text_for_school_and_grade_input_explanation.dart';
import '../parts/text_form_field_for_school_name_input.dart';

class StudentSchoolNameAndGradeInputWidget extends HookWidget {
  final VoidCallback incrementProgressCounter;
  final VoidCallback decrementProgressCounter;
  final TextEditingController studentSchoolNameInputController;
  final String? studentGradeValue;
  final ValueChanged<String?> handleStudentGradeChanged;

  const StudentSchoolNameAndGradeInputWidget(
      {super.key,
      required this.incrementProgressCounter,
      required this.decrementProgressCounter,
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
        const TextForSchoolNameAndGradeInputExplanationText(),
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
              skipCounter: incrementProgressCounter,
            ),
            ButtonForProfileInputNext(
              incrementCounter:
                  (isSchoolNameFilled.value && studentGradeValue != null)
                      ? incrementProgressCounter
                      : null,
            )
          ],
        ),
      ],
    );
  }
}
