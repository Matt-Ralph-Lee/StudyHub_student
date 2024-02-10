import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studyhub/presentation/shared/constants/l10n.dart';

import '../../controllers/sample_controller/sample_controller.dart';
import '../parts/elevated_button_for_auth.dart';
import '../parts/text_form_field_for_email_address_input.dart';
import '../parts/text_form_field_for_password_input.dart';

class SignUpWidget extends HookConsumerWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupEmailController = useTextEditingController();
    final signupPassWordController = useTextEditingController();
    final isEmailFiled = useState<bool>(false);
    void checkEmailFiled(String text) {
      isEmailFiled.value = text.isNotEmpty;
    }

    final isPasswordFiled = useState<bool>(false);
    void checkPasswordFiled(String text) {
      isPasswordFiled.value = text.isNotEmpty;
    }

    return Column(
      children: [
        TextFormFieldForEmailAddressInput(
          controller: signupEmailController,
          onChanged: checkEmailFiled,
        ),
        const SizedBox(height: 25),
        TextFormFieldForPasswordInput(
          controller: signupPassWordController,
          onChanged: checkPasswordFiled,
        ),
        const SizedBox(height: 50),
        ElavatedButtonForAuth(
          buttonText: L10n.signupButtonText,
          onPressed: isEmailFiled.value && isPasswordFiled.value
              ? ref.read(sampleControllerProvider.notifier).login
              : null,
        ),
      ],
    );
  }
}
