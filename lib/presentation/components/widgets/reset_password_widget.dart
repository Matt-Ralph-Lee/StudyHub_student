import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studyhub/presentation/controllers/student_auth_controller/student_auth_controller.dart';

import '../../shared/constants/l10n.dart';
import '../parts/elevated_button_for_auth.dart';
import '../parts/text_for_reset_password_email_address_input_explanation.dart';
import '../parts/text_form_field_for_email_address_input.dart';

class ResetPasswordWidget extends HookConsumerWidget {
  const ResetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailInputErrorText = useState<String?>(null);
    final isEmailFilled = useState<bool>(false);

    void checkEmailFilled(String text) {
      final RegExp emailRegExp =
          RegExp(r'^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$');
      if (text.isEmpty) {
        isEmailFilled.value = false;
        emailInputErrorText.value = 'メールアドレスが空です';
      } else if (!emailRegExp.hasMatch(text)) {
        isEmailFilled.value = false;
        final numOfAts = RegExp(r'@').allMatches(text).length;
        if (numOfAts != 1) {
          emailInputErrorText.value = '@が含まれておらず、メールアドレスの形式ではありません';
        } else if (!text.contains('.')) {
          emailInputErrorText.value = '.が含まれておらず、メールアドレスの形式ではありません';
        } else {
          emailInputErrorText.value = 'メールアドレスの形式ではありません';
        }
      } else {
        isEmailFilled.value = true;
        emailInputErrorText.value = null;
      }
    }

    final forgetPasswordEmailController = useTextEditingController();

    return Column(
      children: [
        const TextForResetPasswordEmailAddressInputExplanation(),
        const SizedBox(height: 80),
        TextFormFieldForEmailAddressInput(
          controller: forgetPasswordEmailController,
          onChanged: checkEmailFilled,
          errorText: emailInputErrorText.value,
        ),
        const SizedBox(height: 80),
        ElevatedButtonForAuth(
            onPressed: isEmailFilled.value
                ? () async {
                    ref
                        .read(studentAuthControllerProvider.notifier)
                        .resetPassword(emailInputErrorText.value!);
                  }
                : null,
            buttonText: L10n.passwordResetButtonText)
      ],
    );
  }
}
