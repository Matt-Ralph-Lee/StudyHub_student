import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../shared/constants/l10n.dart';
import '../parts/button_for_profile_input_back.dart';
import '../parts/button_for_profile_input_next.dart';
import '../parts/button_for_profile_input_skip.dart';
import '../parts/radio_button_for_others_grade_input.dart';
import '../parts/text_for_input_explanation.dart';
import '../parts/text_form_field_for_school_name_input.dart';

class AcademicHistoryInputWidget extends HookWidget {
  final VoidCallback decrementProgressCounter;
  final VoidCallback updateProfile;
  final TextEditingController academicHistoryInputController;
  final String? othersGradeValue;
  final ValueChanged<String?> handleOthersGradeChanged;

  const AcademicHistoryInputWidget(
      {super.key,
      required this.decrementProgressCounter,
      required this.updateProfile,
      required this.academicHistoryInputController,
      required this.othersGradeValue,
      required this.handleOthersGradeChanged});

  @override
  Widget build(BuildContext context) {
    final isAcademicHistoryFilled =
        useState<bool>(academicHistoryInputController.text.isNotEmpty);

    void checkAcademicHistoryFilled(String text) {
      isAcademicHistoryFilled.value = text.isNotEmpty;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TextForProfileInputExplanation(
            explanationText: L10n.academicHistoryInputExplanationText),
        const SizedBox(height: 70),
        TextFormFieldForSchoolNameInput(
          controller: academicHistoryInputController,
          onChanged: checkAcademicHistoryFilled,
        ),
        const SizedBox(height: 50),
        RadioButtonForOthersGradeInput(
          groupValue: othersGradeValue,
          onChanged: handleOthersGradeChanged,
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
                  (isAcademicHistoryFilled.value && othersGradeValue != null)
                      ? updateProfile
                      : null,
            )
          ],
        ),
      ],
    );
  }
}
