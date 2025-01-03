import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/student_auth_controller/student_auth_controller.dart';
import '../../shared/utils/handle_error.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';
import '../parts/elevated_button_for_auth.dart';
import '../parts/text_form_field_for_email_address_input.dart';
import '../parts/text_form_field_for_password_input.dart';
import 'error_modal_widget.dart';

class LoginWidget extends HookConsumerWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginEmailController = useTextEditingController();
    final loginPassWordController = useTextEditingController();
    final emailInputErrorText = useState<String?>(null);
    final passwordInputErrorText = useState<String?>(null);
    final isEmailFilled = useState<bool>(false);
    final isPasswordFilled = useState<bool>(false);

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

    void checkPasswordFilled(String text) {
      if (text.isEmpty) {
        passwordInputErrorText.value = L10n.isPasswordEmptyText;
      }
      isPasswordFilled.value = text.isNotEmpty;
    }

    void push(BuildContext context) {
      context.push(PageId.home.path);
    }

    return Column(
      children: [
        TextFormFieldForEmailAddressInput(
          controller: loginEmailController,
          onChanged: checkEmailFilled,
          errorText: emailInputErrorText.value,
        ),
        const SizedBox(height: 25),
        TextFormFieldForPasswordInput(
          controller: loginPassWordController,
          onChanged: checkPasswordFilled,
          errorText: passwordInputErrorText.value,
        ),
        const SizedBox(height: 40),
        ElevatedButtonForAuth(
          buttonText: L10n.loginButtonText,
          onPressed: isEmailFilled.value && isPasswordFilled.value
              ? () async {
                  await ref.read(studentAuthControllerProvider.notifier).login(
                      loginEmailController.text, loginPassWordController.text);

                  if (!context.mounted) return;

                  final currentState = ref.read(studentAuthControllerProvider);
                  if (currentState.hasError) {
                    final error = currentState.error;
                    final errorMessage = handleError(error);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorModalWidget(
                            errorMessage: errorMessage,
                          );
                        });
                  } else {
                    push(context);
                  }
                }
              : null,
        ),
      ],
    );
  }
}
