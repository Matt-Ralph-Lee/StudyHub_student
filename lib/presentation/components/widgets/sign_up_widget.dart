import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/student_auth_controller/student_auth_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/utils/handle_error.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';
import '../parts/elevated_button_for_auth.dart';
import '../parts/text_form_field_for_email_address_input.dart';
import '../parts/text_form_field_for_password_input.dart';
import 'error_modal_widget.dart';

class SignUpWidget extends HookConsumerWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpEmailController = useTextEditingController();
    final signUpPassWordController = useTextEditingController();
    final isEmailFilled = useState<bool>(false);
    final isPasswordFilled = useState<bool>(false);
    final isCheckedTermsOfUse = useState<bool>(false);
    final isCheckedPrivacyPolicy = useState<bool>(false);
    final emailInputErrorText = useState<String?>(null);
    final passwordInputErrorText = useState<String?>(null);
    final termsOfUseUrl = Uri.parse(L10n.termsOfUseUrlText);
    final privacyPolicyUrl = Uri.parse(L10n.privacyPolicyUrlText);

    void checkEmailFilled(String text) {
      final RegExp emailRegExp =
          RegExp(r'^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$');
      if (text.isEmpty) {
        isEmailFilled.value = false;
        emailInputErrorText.value = L10n.emailIsEmptyText;
      } else if (!emailRegExp.hasMatch(text)) {
        isEmailFilled.value = false;
        final numOfAts = RegExp(r'@').allMatches(text).length;
        if (numOfAts != 1) {
          emailInputErrorText.value = L10n.notContainAtText;
        } else if (!text.contains('.')) {
          emailInputErrorText.value = L10n.notContainDotText;
        } else {
          emailInputErrorText.value = L10n.invalidEmailText;
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

    void handleTermsOfUseCheckbox(bool? isChecked) {
      HapticFeedback.lightImpact();
      isCheckedTermsOfUse.value = isChecked!;
    }

    void handlePrivacyPolicyCheckbox(bool? isChecked) {
      HapticFeedback.lightImpact();
      isCheckedPrivacyPolicy.value = isChecked!;
    }

    void push(BuildContext context) {
      context.push(
        PageId.emailVerificationPage.path,
        extra: signUpEmailController.text,
      );
    }

    void pushDummy(BuildContext context) {
      context.push(PageId.home.path);
    }

    void dummySignUp(BuildContext context) async {
      ref
          .read(studentAuthControllerProvider.notifier)
          .signUp("hoge@gmail.com", "hogehoge")
          .then((_) {
        final currentState = ref.read(studentAuthControllerProvider);
        if (currentState.hasError) {
          final error = currentState.error;
          handleError(error);
        } else {
          pushDummy(context);
        }
      });
    }

    return Column(
      children: [
        ElevatedButton(
          onPressed: () => dummySignUp(context),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          child: const Text("a"),
        ),
        TextFormFieldForEmailAddressInput(
          controller: signUpEmailController,
          onChanged: checkEmailFilled,
          errorText: emailInputErrorText.value,
        ),
        const SizedBox(height: 25),
        TextFormFieldForPasswordInput(
          controller: signUpPassWordController,
          onChanged: checkPasswordFilled,
          errorText: passwordInputErrorText.value,
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: isCheckedTermsOfUse.value,
                onChanged: handleTermsOfUseCheckbox,
                activeColor: ColorSet.of(context).primary,
                checkColor: ColorSet.of(context).whiteText,
                side: BorderSide(
                  width: 1,
                  color: ColorSet.of(context).greySurface,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => launchUrl(termsOfUseUrl),
              child: Text(
                L10n.termsOfUseText,
                style: TextStyle(
                  color: ColorSet.of(context).primary,
                  fontWeight: FontWeightSet.normal,
                  fontSize: FontSizeSet.getFontSize(
                    context,
                    FontSizeSet.body,
                  ),
                ),
              ),
            ),
            Text(
              L10n.douisuruText,
              style: TextStyle(
                color: ColorSet.of(context).text,
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(
                  context,
                  FontSizeSet.body,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: isCheckedPrivacyPolicy.value,
                onChanged: handlePrivacyPolicyCheckbox,
                activeColor: ColorSet.of(context).primary,
                checkColor: ColorSet.of(context).whiteText,
                side: BorderSide(
                  width: 1,
                  color: ColorSet.of(context).greySurface,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => launchUrl(privacyPolicyUrl),
              child: Text(
                L10n.privacyPolicyText,
                style: TextStyle(
                  color: ColorSet.of(context).primary,
                  fontWeight: FontWeightSet.normal,
                  fontSize: FontSizeSet.getFontSize(
                    context,
                    FontSizeSet.body,
                  ),
                ),
              ),
            ),
            Text(
              L10n.douisuruText,
              style: TextStyle(
                color: ColorSet.of(context).text,
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(
                  context,
                  FontSizeSet.body,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        ElevatedButtonForAuth(
          buttonText: L10n.signUpButtonText,
          onPressed: isEmailFilled.value &&
                  isPasswordFilled.value &&
                  isCheckedTermsOfUse.value &&
                  isCheckedPrivacyPolicy.value
              ? () async {
                  ref
                      .read(studentAuthControllerProvider.notifier)
                      .signUp(signUpEmailController.text,
                          signUpPassWordController.text)
                      .then((_) {
                    final currentState =
                        ref.read(studentAuthControllerProvider);
                    if (currentState.hasError) {
                      final error = currentState.error;
                      final errorMessage = handleError(error);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorModalWidget(
                            errorMessage: errorMessage,
                          );
                        },
                      );
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
