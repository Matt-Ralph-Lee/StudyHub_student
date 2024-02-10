import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studyhub/presentation/shared/constants/l10n.dart';

import '../../controllers/sample_controller/sample_controller.dart';
import '../parts/elevated_button_for_auth.dart';
import '../parts/text_for_reset_password_email_address_input_explanation.dart';
import '../parts/text_form_field_for_email_address_input.dart';

class ResetPasswordWidget extends HookConsumerWidget {
  const ResetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEmailFiled = useState<bool>(false);
    void checkEmailFiled(String text) {
      isEmailFiled.value = text.isNotEmpty;
    }

    final forgetPasswordEmailController = useTextEditingController();

    return Column(
      children: [
        const TextForResetPasswordEmailAddressInputExplanation(),
        const SizedBox(height: 80),
        TextFormFieldForEmailAddressInput(
          controller: forgetPasswordEmailController,
          onChanged: checkEmailFiled,
        ),
        const SizedBox(height: 80),
        ElavatedButtonForAuth(
            onPressed: isEmailFiled.value
                ? ref.read(sampleControllerProvider.notifier).resetPassword
                : null,
            buttonText: L10n.passwordResetButtonText)
      ],
    );
  }
}
