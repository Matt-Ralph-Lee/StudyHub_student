import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/student_auth/exception/student_auth_domain_exception.dart';
import '../../../domain/student_auth/exception/student_auth_domain_exception_detail.dart';
import '../../controllers/student_auth_controller/student_auth_controller.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';
import '../parts/elevated_button_for_auth.dart';
import '../parts/text_form_field_for_email_address_input.dart';
import '../parts/text_form_field_for_password_input.dart';
import 'show_domain_exception_modal_widget.dart';
import 'show_error_modal_widget.dart';

class SignUpWidget extends HookConsumerWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpEmailController = useTextEditingController();
    final signUpPassWordController = useTextEditingController();
    final isEmailFilled = useState<bool>(false);
    final isPasswordFilled = useState<bool>(false);

    void checkEmailFilled(String text) {
      isEmailFilled.value = text.isNotEmpty;
    }

    void checkPasswordFilled(String text) {
      isPasswordFilled.value = text.isNotEmpty;
    }

    void push(BuildContext context) {
      context.push(PageId.evaluationPage.path);
    }

    return Column(
      children: [
        TextFormFieldForEmailAddressInput(
          controller: signUpEmailController,
          onChanged: checkEmailFilled,
        ),
        const SizedBox(height: 25),
        TextFormFieldForPasswordInput(
          controller: signUpPassWordController,
          onChanged: checkPasswordFilled,
        ),
        SizedBox(height: 50),
        ElevatedButtonForAuth(
          buttonText: L10n.signUpButtonText,
          onPressed: isEmailFilled.value && isPasswordFilled.value
              ? () async {
                  ref
                      .read(studentAuthControllerProvider.notifier)
                      .signUp(signUpEmailController.text,
                          signUpPassWordController.text)
                      .then((_) {
                    final currentState =
                        ref.read(studentAuthControllerProvider);
                    if (currentState is AsyncError) {
                      final error = currentState.error;
                      if (error is StudentAuthDomainException) {
                        final errorText = L10n.getStudentAuthExceptionMessage(
                            error.detail as StudentAuthDomainExceptionDetail);
                        showDomainExceptionModalWidget(context, errorText);
                      } else {
                        showErrorModalWidget(context);
                      }
                    } else {
                      push(context);
                    }
                  });
                }
              : null,
        ),
      ],
    );
  }
}
