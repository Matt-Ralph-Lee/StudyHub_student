import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../parts/elevated_button_for_auth.dart';
import '../parts/text_for_reset_password_mail_address_input_explanation.dart';
import '../parts/text_form_field_for_mail_address_input.dart';

class ResetPassswordWidget extends HookWidget {
  ResetPassswordWidget({super.key});

  final forgetPasswordEmailController = useTextEditingController();

  @override
  Widget build(BuildContext context) {
    final isEnabled = useState<bool>(false);
    void onTextChanged(String text) {
      isEnabled.value = text.isNotEmpty;
    }

    return Material(
      child: Column(
        children: [
          const TextForResetPasswordMailAddressInputExplanation(),
          const SizedBox(height: 80),
          TextFormFieldForMailAddressInput(
            controller: forgetPasswordEmailController,
            onChanged: onTextChanged,
          ),
          const SizedBox(height: 80),
          ElavatedButtonForAuth(
              onPressed:
                  isEnabled.value && isEnabled.value ? ResetPassword : null,
              buttonText: "再設定用のメールアドレスを送信")
        ],
      ),
    );
  }
}

void ResetPassword() {}
