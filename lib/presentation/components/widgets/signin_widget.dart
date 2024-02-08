import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/sample_controller/sample_controller.dart';
import '../parts/elevated_button_for_auth.dart';
import '../parts/text_form_field_for_mail_address_input.dart';
import '../parts/text_form_field_for_password_input.dart';

class SignInWidget extends HookConsumerWidget {
  const SignInWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInEmailController = useTextEditingController();
    final signInPassWordController = useTextEditingController();
    final isEnabled = useState<bool>(false);
    void onTextChanged(String text) {
      isEnabled.value = text.isNotEmpty;
    }

    final isEnabled2 = useState<bool>(false);
    void onTextChanged2(String text) {
      isEnabled2.value = text.isNotEmpty;
    }

    return Column(
      children: [
        TextFormFieldForMailAddressInput(
          controller: signInEmailController,
          onChanged: onTextChanged,
        ),
        const SizedBox(height: 25),
        TextFormFieldForPasswordInput(
          controller: signInPassWordController,
          onChanged: onTextChanged2,
        ),
        const SizedBox(height: 50),
        ElavatedButtonForAuth(
          buttonText: "サインイン",
          onPressed: isEnabled.value && isEnabled2.value
              ? ref.read(sampleControllerProvider.notifier).login
              : null,
        ),
      ],
    );
  }
}
