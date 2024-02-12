import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../parts/button_for_profile_input_back.dart';
import '../parts/button_for_profile_input_next.dart';
import '../parts/radio_button_for_gender_input.dart';
import '../parts/radio_button_for_job_input.dart';
import '../parts/text_for_gender_and_job_input_explanation.dart';

class GenderAndJobInputWidget extends HookWidget {
  final String? genderValue;
  final String? jobValue;
  final ValueChanged<String?> handleGenderChanged;
  final ValueChanged<String?> handleJobChanged;
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
        const TextForGenderAndJobInputExplanation(),
        const SizedBox(height: 100),
        RadioButtonForGenderInput(
          groupValue: genderValue,
          onChanged: handleGenderChanged,
        ),
        const SizedBox(height: 50),
        RadioButtonForJobInput(
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
