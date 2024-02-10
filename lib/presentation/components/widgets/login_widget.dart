import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studyhub/presentation/shared/constants/l10n.dart';

import '../../controllers/sample_controller/sample_controller.dart';
import '../parts/elevated_button_for_auth.dart';
import '../parts/text_form_field_for_email_address_input.dart';
import '../parts/text_form_field_for_password_input.dart';

class LoginWidget extends HookConsumerWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginEmailController = useTextEditingController();
    final loginPassWordController = useTextEditingController();
    final isEmailFilled = useState<bool>(false);
    void checkEmailFilled(String text) {
      isEmailFilled.value = text.isNotEmpty;
    }

    final isPassworeFilled = useState<bool>(false);
    void checkPasswordFilled(String text) {
      isPassworeFilled.value = text.isNotEmpty;
    }

    return Column(
      children: [
        TextFormFieldForEmailAddressInput(
          controller: loginEmailController,
          onChanged: checkEmailFilled,
        ),
        const SizedBox(height: 25),
        TextFormFieldForPasswordInput(
          controller: loginPassWordController,
          onChanged: checkPasswordFilled,
        ),
        const SizedBox(height: 50),
        ElavatedButtonForAuth(
          buttonText: L10n.loginButtonText,
          onPressed: isEmailFilled.value && isPassworeFilled.value
              ? ref.read(sampleControllerProvider.notifier).login
              : null,
        ),
      ],
    );
  }
}
