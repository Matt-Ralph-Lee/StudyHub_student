import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/shared/name.dart';
import '../../shared/constants/l10n.dart';
import '../parts/button_for_profile_input_next.dart';
import '../parts/text_for_input_explanation.dart';
import '../parts/text_form_field_for_user_name_input.dart';

class UserNameInputWidget extends HookWidget {
  final TextEditingController userNameInputController;
  final VoidCallback incrementProgressCounter;
  const UserNameInputWidget({
    super.key,
    required this.userNameInputController,
    required this.incrementProgressCounter,
  });

  @override
  Widget build(BuildContext context) {
    final isUserNameFilled =
        useState<bool>(userNameInputController.text.isNotEmpty);
    final userNameErrorText = useState<String?>(null);

    void checkUserNameFilled(String text) {
      if (text.length > Name.maxLength) {
        userNameErrorText.value = L10n.userNameErrorText;
        isUserNameFilled.value = false; //trueの状態でmaxLengthをoverする場合もあるので
      } else {
        userNameErrorText.value = null;
        isUserNameFilled.value = text.isNotEmpty;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TextForProfileInputExplanation(
            explanationText: L10n.usernameInputExplanationText),
        const SizedBox(height: 130),
        TextFormFieldForUserNameInput(
          controller: userNameInputController,
          onChanged: checkUserNameFilled,
          errorText: userNameErrorText.value,
        ),
        const SizedBox(height: 150),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonForProfileInputNext(
              incrementCounter:
                  isUserNameFilled.value ? incrementProgressCounter : null,
            )
          ],
        ),
      ],
    );
  }
}
