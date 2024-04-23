import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/occupation.dart';
import '../../shared/constants/l10n.dart';
import '../parts/button_for_profile_input_back.dart';
import '../parts/button_for_profile_input_next.dart';
import '../parts/drop_down_button_for_gender_input.dart';
import '../parts/drop_down_button_for_occupation_input.dart';
import '../parts/text_for_input_explanation.dart';

class GenderAndJobInputWidget extends HookWidget {
  final Gender? genderValue;
  final Occupation? jobValue;
  final ValueChanged<Gender?> handleGenderChanged;
  final ValueChanged<Occupation?> handleJobChanged;
  final VoidCallback incrementProgressCounter;
  final VoidCallback decrementProgressCounter;

  const GenderAndJobInputWidget({
    super.key,
    required this.genderValue,
    required this.jobValue,
    required this.handleGenderChanged,
    required this.handleJobChanged,
    required this.incrementProgressCounter,
    required this.decrementProgressCounter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TextForProfileInputExplanation(
            explanationText: L10n.genderAndJobInputExplanationText),
        const SizedBox(height: 100),
        DropDownButtonForGenderInput(
          groupValue: genderValue,
          onChanged: handleGenderChanged,
        ),
        const SizedBox(height: 50),
        DropDownButtonForOccupationInput(
          groupValue: jobValue,
          onChanged: handleJobChanged,
        ),
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonForProfileInputBack(
              decrementCounter: decrementProgressCounter,
            ),
            ButtonForProfileInputNext(
              incrementCounter: (genderValue != null && jobValue != null)
                  ? incrementProgressCounter
                  : null,
            )
          ],
        ),
      ],
    );
  }
}
