import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/student_auth_controller/student_auth_controller.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';
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

    final isPasswordFilled = useState<bool>(false);
    void checkPasswordFilled(String text) {
      isPasswordFilled.value = text.isNotEmpty;
    }

    void push(BuildContext context) {
      context.push(PageId.evaluationPage.path);
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
        ElevatedButtonForAuth(
          buttonText: L10n.loginButtonText,
          onPressed: isEmailFilled.value && isPasswordFilled.value
              ? () {
                  ref
                      .read(studentAuthControllerProvider.notifier)
                      .login(loginEmailController.text,
                          loginPassWordController.text)
                      .then((_) {
                    push(context);
                  });
                }
              : null,
        ),
      ],
    );
  }
}
